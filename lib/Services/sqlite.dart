import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/models/user.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService extends GetxService {
  Database? database;

  Future<SqliteService> init() async {
    await getDatabase();
    await createTable();
    return this;
  }

  Future<void> getDatabase() async {
    database ??= await openDatabase(
      'db1.db',
      version: 1,
      singleInstance: true,
      onOpen: (db) {},
    );
  }

  Future<void> createTable() async {
    // user table
    await database?.execute(
      '''CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        age INTEGER,
        gender TEXT,
        created_at DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW')),
        updated_at DATETIME NOT NULL DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW'))
      );
      ''',
    );
    // habits table
    await database?.execute(
      '''CREATE TABLE IF NOT EXISTS habits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        icon INTEGER,
        icon_font_family TEXT DEFAULT 'MaterialIcons',
        color INTEGER,
        goal INTEGER NOT NULL,
        time INTEGER NOT NULL,
        rate TEXT NOT NULL,
        reminder_time DATETIME NOT NULL,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        FOREIGN KEY (user) REFERENCES users(id)
      );
      ''',
    );

    // habit logs table
    await database?.execute(
      '''CREATE TABLE IF NOT EXISTS habit_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        date DATETIME,
        action TEXT NOT NULL CHECK (action IN ('complete', 'reverse')),
        reversed_log INTEGER DEFAULT NULL REFERENCES habit_logs(id),
        note TEXT,
        habit_id INTEGER NOT NULL,
        is_late BOOLEAN,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (habit_id) REFERENCES habits(id),
        FOREIGN KEY (reversed_log) REFERENCES habit_logs(id)
      );
      ''',
    );
  }

  Future<User> getUser(int id) async {
    final List<Map<String, Object?>>? maps =
        await database?.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps == null || maps.isEmpty) {
      throw Exception('User not found');
    }
    return User.fromJson(maps.first);
  }

  Future<User> login(String email, String password) async {
    var user =
        await database?.query('users', where: 'email = ?', whereArgs: [email]);
    if (user == null || user.isEmpty) {
      throw Exception('User not found');
    }
    if (user.first['password'] != password) {
      throw Exception('Invalid password');
    }
    return User.fromJson(user.first);
  }

  Future<User> getUserByEmail(String email) async {
    final List<Map<String, Object?>>? maps =
        await database?.query('users', where: 'email = ?', whereArgs: [email]);
    if (maps == null || maps.isEmpty) {
      throw Exception('User not found');
    }
    return User.fromJson(maps.first);
  }

  Future<void> insertUser(Map<String, dynamic> data) async {
    data['created_at'] = DateTime.now().toIso8601String();
    await database?.insert('users', data);
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    data['updated_at'] = DateTime.now().toIso8601String();
    await database
        ?.update('users', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<void> deleteUser(int id) async {
    await database?.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<Habit> getHabit(int id) async {
    final List<Map<String, Object?>>? maps =
        await database?.query('habits', where: 'id = ?', whereArgs: [id]);
    if (maps == null || maps.isEmpty) {
      throw Exception('Habit not found');
    }
    //resolve streak
    int streak = await getHabitStreak(maps.first['id'] as int);
    Map<String, dynamic> map = Map<String, dynamic>.from(maps.first);
    map['streak'] = streak;
    DateTime reminderTime = DateTime.parse(map['reminder_time']);
    DateTime? lastCompleted =
        await getLastHabitLog(map['id'] as int).then((log) => log?.date);
    DateTime nextDue =
        calculateNextDue(reminderTime, map['rate'], lastCompleted);
    map["lastCompleted"] = lastCompleted?.toIso8601String();
    map['nextDue'] = nextDue.toIso8601String();

    return Habit.fromJson(map);
  }

  Future<void> insertHabit(Habit habit, int userId) async {
    final now = DateTime.now().toIso8601String();
    final Map<String, dynamic> data = {
      ...habit.toJson(),
      'user': userId,
      'created_at': now,
      'updated_at': now,
    };

    await database?.insert('habits', data);
  }

  Future<void> updateHabit(Habit habit) async {
    dynamic data = habit.toJson();
    data['updated_at'] = DateTime.now().toIso8601String();
    await database
        ?.update('habits', data, where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<void> deleteHabit(Habit habit) async {
    await database?.delete('habits', where: 'id = ?', whereArgs: [habit.id]);
  }

  Future<List<Habit>> getHabits(int userId, {int? limit, int? offset}) async {
    List<Map<String, dynamic>> maps;
    if (limit == null || offset == null) {
      maps = await database?.query('habits',
              where: 'user = ?', whereArgs: [userId], orderBy: 'id DESC') ??
          [];
    } else {
      maps = await database?.query('habits',
              where: 'user = ?',
              whereArgs: [userId],
              orderBy: 'id DESC',
              limit: limit,
              offset: offset) ??
          [];
    }

    if (maps.isEmpty) {
      return [];
    }

    // Resolve streak
    List<int> habitIds = maps.map((map) => map['id'] as int).toList();
    List<int> streaks = await getHabitsStreaks(habitIds);
    List<HabitLog> lastLogs = await logsByHabitIds(habitIds);
    List<DateTime?> lastCompleted =
        List<DateTime?>.filled(habitIds.length, null);

    for (var log in lastLogs) {
      int index = habitIds.indexOf(log.habitId);
      if (index != -1) {
        lastCompleted[index] = log.date;
      }
    }

    // Create a new list of maps with the streak information and next due date
    List<Map<String, dynamic>> updatedMaps = maps.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> map = Map<String, dynamic>.from(entry.value);
      map['streak'] = streaks[index];
      DateTime reminderTime = DateTime.parse(map['reminder_time']);
      try {
        map["lastCompleted"] = lastCompleted[index]!.toIso8601String();
      } catch (e) {
        map["lastCompleted"] = null;
      }
      DateTime nextDue = calculateNextDue(
          reminderTime,
          map['rate'],
          map["lastCompleted"] != null
              ? DateTime.parse(map["lastCompleted"])
              : null);
      map['nextDue'] = nextDue.toIso8601String();

      return map;
    }).toList();
    //sort by nextDue
    updatedMaps.sort((a, b) =>
        DateTime.parse(a['nextDue']).compareTo(DateTime.parse(b['nextDue'])));
    return updatedMaps.map((map) => Habit.fromJson(map)).toList();
  }

  DateTime calculateNextDue(
    DateTime reminderTime,
    String rate,
    DateTime? lastCompleted,
  ) {
    DateTime now = DateTime.now();
    if (lastCompleted == null) {
      return now.isAfter(reminderTime)
          ? now.add(const Duration(days: 1)).copyWith(
                hour: reminderTime.hour,
                minute: reminderTime.minute,
              )
          : reminderTime;
    }

    return lastCompleted.add(const Duration(days: 1)).copyWith(
          hour: reminderTime.hour,
          minute: reminderTime.minute,
        );
  }

  Future<HabitLog?> getLastHabitLog(int habitId) async {
    final List<Map<String, Object?>>? maps = await database?.query('habit_logs',
        where: 'habit_id = ?', whereArgs: [habitId], orderBy: 'date DESC');
    if (maps == null || maps.isEmpty) {
      return null;
    }
    return HabitLog.fromJson(maps.first);
  }

  Future<List<HabitLog>> logsByHabitIds(List<int> habitIds) async {
    final List<Map<String, Object?>>? maps = await database?.query('habit_logs',
        where: 'habit_id IN (${habitIds.map((e) => '?').join(', ')})',
        whereArgs: habitIds,
        orderBy: 'date DESC');
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((map) => HabitLog.fromJson(map)).toList();
  }

  Future<List<HabitLog>> getHabitLogs(int habitId,
      {int? limit, int? offset}) async {
    if (limit == null || offset == null) {
      final List<Map<String, Object?>>? maps = await database?.query(
          'habit_logs',
          where: 'habit_id = ?',
          whereArgs: [habitId],
          orderBy: 'date DESC');
      if (maps == null || maps.isEmpty) {
        return [];
      }
      return maps.map((map) => HabitLog.fromJson(map)).toList();
    } else {
      final List<Map<String, Object?>>? maps = await database?.query(
          'habit_logs',
          where: 'habit_id = ?',
          whereArgs: [habitId],
          orderBy: 'date DESC',
          limit: limit,
          offset: offset);
      if (maps == null || maps.isEmpty) {
        return [];
      }
      return maps.map((map) => HabitLog.fromJson(map)).toList();
    }
  }

  Future<List<HabitLog>> getHabitLogsByDateRange(
      DateTime startDate, DateTime endDate, int habitId) async {
    final List<Map<String, Object?>>? maps = await database?.query('habit_logs',
        where: 'date BETWEEN ? AND ? AND habit_id = ?',
        whereArgs: [
          startDate.toIso8601String(),
          endDate.toIso8601String(),
          habitId
        ],
        orderBy: 'date DESC');
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((map) => HabitLog.fromJson(map)).toList();
  }

  Future<void> insertHabitLog(HabitLog habitLog, int userId) async {
    try {
      dynamic data = habitLog.toJson();
      if (data['action'] == 'reverse') {
        HabitLog? lastLog = await getLastHabitLog(habitLog.habitId);
        if (lastLog == null) {
          throw Exception('Cannot reverse habit log');
        }
        if (lastLog.action != 'complete') {
          throw Exception('Cannot reverse habit log');
        }
      }
      data['date'] = DateTime.now().toIso8601String();
      data['user_id'] = userId;
      Habit habit = await getHabit(habitLog.habitId);
      data['habit_id'] = habit.id;
      data['is_late'] =
          DateTime.now().difference(habit.nextDue).inMinutes > 60 ? 1 : 0;
      // Check if a log already exists on the same habit id
      HabitLog? existingLog = await getLastHabitLog(habitLog.habitId);
      if (existingLog != null &&
          existingLog.action == 'complete' &&
          existingLog.date?.day == DateTime.now().day) {
        throw Exception('Cannot complete habit log');
      }
      await database?.insert('habit_logs', data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> getHabitStreak(int habitId) async {
    final DateTime today = DateTime.now();
    final DateTime earliestDate = DateTime(today.year, today.month,
        today.day - 365); // Assuming a year's worth of data
    final List<Map<String, Object?>>? maps = await database?.query('habit_logs',
        where: 'habit_id = ? AND date BETWEEN ? AND ?',
        whereArgs: [
          habitId,
          earliestDate.toIso8601String(),
          today.toIso8601String()
        ],
        orderBy: 'date DESC');
    if (maps == null || maps.isEmpty) {
      return 0;
    }
    int streak = 1;
    DateTime lastDate = DateTime.parse(maps.first['date'].toString());
    for (int i = 1; i < maps.length; i++) {
      final DateTime currentDate = DateTime.parse(maps[i]['date'].toString());
      if ((lastDate.difference(currentDate)).inDays == 1) {
        streak++;
      } else {
        break;
      }
      lastDate = currentDate;
    }

    return streak;
  }

  Future<List<int>> getHabitsStreaks(List<int> habitIds) async {
    final DateTime today = DateTime.now();
    final DateTime earliestDate = DateTime(today.year, today.month,
        today.day - 365); // Assuming a year's worth of data
    final List<Map<String, Object?>>? maps = await database?.query('habit_logs',
        where:
            'habit_id IN (${habitIds.map((e) => '?').join(', ')}) AND date BETWEEN ? AND ?',
        whereArgs: [
          ...habitIds,
          earliestDate.toIso8601String(),
          today.toIso8601String()
        ],
        orderBy: 'date DESC, habit_id ASC');
    if (maps == null || maps.isEmpty) {
      return List.filled(habitIds.length, 0);
    }
    //remove reverse logs
    dynamic reversedLogs = maps.where((map) => map['action'] == 'reverse');
    await database?.execute(
        'DELETE FROM habit_logs WHERE id IN (${reversedLogs.map((e) => e['id']).join(', ')})');
    // List<int?> reversedLogParentIds =
    //     reversedLogs.map((log) => log['reversed_log'] as int).toList();
    // maps.removeWhere((map) => reversedLogParentIds.contains(map['id']));
    // maps.removeWhere((map) => map['action'] == 'reverse');
    List<int> streaks = List.filled(habitIds.length, 0);
    Map<int, int> habitStreaks = {};
    int currentStreak = 1;
    DateTime lastDate = DateTime.parse(maps.first['date'].toString());
    for (int i = 1; i < maps.length; i++) {
      final DateTime currentDate = DateTime.parse(maps[i]['date'].toString());
      if ((lastDate.difference(currentDate)).inDays == 1 &&
          maps[i]['habit_id'] == maps[i - 1]['habit_id']) {
        currentStreak++;
      } else {
        if (currentStreak > 0) {
          habitStreaks.addAll({maps[i - 1]['habit_id'] as int: currentStreak});
          currentStreak = 1;
        }
      }
      lastDate = currentDate;
    }
    if (currentStreak > 0) {
      habitStreaks.addAll({maps.last['habit_id'] as int: currentStreak});
    }
    for (int i = 0; i < habitIds.length; i++) {
      streaks[i] = habitStreaks.containsKey(habitIds[i])
          ? habitStreaks[habitIds[i]]!
          : 0;
    }
    return streaks;
  }

  Future<void> closeDatabase() async {
    await database?.close();
  }
}
