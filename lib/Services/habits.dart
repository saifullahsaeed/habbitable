import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';

class HabitsService extends GetxController {
  final List<Habit> _habits = [
    Habit(
      id: "1",
      name: "Morning Exercise",
      description: "Start your day with a 30-minute exercise routine.",
      icon: Icons.run_circle,
      color: Colors.green,
      streak: 5,
      goal: 30,
      time: 30,
      rate: "Daily",
      lastCompleted: DateTime.now().subtract(const Duration(days: 1)),
      nextDue: DateTime.now(),
      isOnProbation: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Habit(
      id: "2",
      name: "Daily Reading",
      description: "Spend 15 minutes reading a book.",
      icon: Icons.book,
      color: Colors.blue,
      streak: 10,
      goal: 15,
      time: 15,
      rate: "Daily",
      lastCompleted: DateTime.now().subtract(const Duration(days: 1)),
      nextDue: DateTime.now(),
      isOnProbation: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Habit(
      id: "3",
      name: "Evening Meditation",
      description: "Practice meditation for 10 minutes before bed.",
      icon: Icons.macro_off,
      color: Colors.purple,
      streak: 3,
      goal: 10,
      time: 10,
      rate: "Daily",
      lastCompleted: DateTime.now().subtract(const Duration(days: 1)),
      nextDue: DateTime.now(),
      isOnProbation: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Habit(
      id: "4",
      name: "Drink Water",
      description: "Drink 8 glasses of water a day.",
      icon: Icons.water_drop,
      color: Colors.orange,
      streak: 30,
      goal: 8,
      time: 0,
      rate: "Daily",
      lastCompleted: DateTime.now().subtract(const Duration(days: 1)),
      nextDue: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        12,
        0,
      ),
      isOnProbation: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<Habit> get habits => _habits;
  Future<List<Habit>> getHabits() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _habits;
  }

  Future<void> createHabit(Habit habit) async {
    _habits.add(habit);
  }

  Future<void> updateHabit(Habit habit) async {
    _habits.removeWhere((h) => h.id == habit.id);
    _habits.add(habit);
  }

  Future<void> deleteHabit(String id) async {
    _habits.removeWhere((h) => h.id == id);
  }

  Future<void> completeHabit(String id) async {
    _habits.firstWhere((h) => h.id == id).streak++;
    _habits.firstWhere((h) => h.id == id).lastCompleted = DateTime.now();
    _habits.firstWhere((h) => h.id == id).nextDue = DateTime.now().add(
      const Duration(
        days: 1,
      ),
    );
  }

  Future<void> undoHabit(String id) async {
    _habits.firstWhere((h) => h.id == id).streak--;
    _habits.firstWhere((h) => h.id == id).lastCompleted = DateTime.now();
    _habits.firstWhere((h) => h.id == id).nextDue = DateTime.now().add(
      const Duration(
        days: 1,
      ),
    );
  }
}
