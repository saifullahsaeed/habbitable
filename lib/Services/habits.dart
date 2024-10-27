import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/sqlite.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/repos/habits.dart';
import 'package:habbitable/utils/snackbar.dart';

class HabitsService extends GetxController {
  static const String _habitsFilePath = 'assets/data/habits.json';
  SqliteService sqliteService = Get.find<SqliteService>();
  GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  HabitsRepository habitsRepository = HabitsRepository();
  @override
  void onInit() {
    super.onInit();
    // testInsert();
  }

  Future<List<Habit>> getHabits() async {
    final res = await habitsRepository.getHabits();
    final List<Habit> habits =
        res.data.map((h) => Habit.fromJson(h)).toList().cast<Habit>();
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
    try {
      await habitsRepository.createHabit(habit);
      showSnackBar(
        title: 'Success',
        message: 'Habit created successfully',
        type: 'success',
      );
      Get.back();
    } catch (e) {
      showSnackBar(
        title: 'Error',
        message: e.toString(),
        type: 'error',
      );
    }
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
