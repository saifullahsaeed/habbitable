import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/sqlite.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';

class HabitsService extends GetxController {
  static const String _habitsFilePath = 'assets/data/habits.json';
  SqliteService sqliteService = Get.find<SqliteService>();
  GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();

  @override
  void onInit() {
    super.onInit();
    // testInsert();
  }

  Future<List<Habit>> getHabits() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final int userId = (await authService.currentUser()).id;
    final List<Habit> habits = await sqliteService.getHabits(userId);
    return habits;
  }

  Future<void> testInsert() async {
    final int userId = (await authService.currentUser()).id;
    final HabitLog habitLog = HabitLog(id: 1, habitId: 1, action: 'complete');
    await sqliteService.insertHabitLog(habitLog, userId);
    // print(habits);
  }

  Future<void> _saveHabits(List<dynamic> habits) async {
    final file = File(_habitsFilePath);
    await file.writeAsString(jsonEncode(habits));
  }

  Future<void> createHabit(Habit habit) async {
    final habits = await getHabits();
    habits.add(habit);
    await _saveHabits(habits.map((h) => h.toJson()).toList());
  }

  Future<void> updateHabit(Habit habit) async {
    //read json file
    final json = await rootBundle.loadString(_habitsFilePath);
    final List<dynamic> habits = jsonDecode(json);
    habits.removeWhere((h) => h['id'] == habit.id);
    habits.add(habit.toJson());
    await _saveHabits(habits);
  }

  Future<void> deleteHabit(String id) async {
    //read json file
    final json = await rootBundle.loadString(_habitsFilePath);
    final List<dynamic> habits = jsonDecode(json);
    habits.removeWhere((h) => h['id'] == id);
    await _saveHabits(habits);
  }

  Future<void> completeHabit(String id) async {
    final int userId = (await authService.currentUser()).id;
    final HabitLog habitLog =
        HabitLog(habitId: int.parse(id), action: 'complete');
    await sqliteService.insertHabitLog(habitLog, userId);
  }

  Future<void> undoHabit(String id) async {
    final int userId = (await authService.currentUser()).id;
    final HabitLog habitLog =
        HabitLog(habitId: int.parse(id), action: 'reverse');
    await sqliteService.insertHabitLog(habitLog, userId);
  }

  Future<List<HabitLog>> getHabitLogsRange(
      int habitId, DateTime startDate, DateTime endDate) async {
    final List<HabitLog> habitLogs = await sqliteService
        .getHabitLogsByDateRange(startDate, endDate, habitId);
    return habitLogs;
  }
}
