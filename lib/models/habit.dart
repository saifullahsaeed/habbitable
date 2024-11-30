import 'package:flutter/material.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/utils/functions.dart';

class Habit {
  final int id;
  final String name;
  final String? description;
  final IconData icon;
  final String iconFontFamily;
  final Color color;
  int streak;
  final int goal;
  final int time;
  final String frequency;
  DateTime? lastCompleted;
  DateTime nextDue;
  User owner;
  List<User> users;
  List<String> customDays;
  final bool isPublic;
  final TimeOfDay reminderTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Habit({
    required this.id,
    required this.name,
    this.description,
    this.icon = Icons.star,
    this.iconFontFamily = "MaterialIcons",
    this.color = Colors.blue,
    required this.streak,
    required this.goal,
    required this.time,
    required this.frequency,
    this.lastCompleted,
    required this.nextDue,
    required this.reminderTime,
    required this.owner,
    required this.users,
    required this.customDays,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  bool isCompleted() {
    return lastCompleted?.day == DateTime.now().day;
  }

  bool isDelayed() {
    return nextDue.isBefore(
        DateTime.now().copyWith(minute: 0, second: 0, millisecond: 0));
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      icon: json['icon'] != null
          ? iconDataFromString(int.parse(json['icon']), json['iconFontFamily'])
          : Icons.star,
      iconFontFamily: json['iconFontFamily'] ?? "MaterialIcons",
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.blue,
      streak: json['streak'] ?? 0,
      goal: json['goal'] ?? 0,
      time: json['time'] ?? 10,
      frequency: json['frequency'],
      lastCompleted: json['lastCompleted'] != null
          ? DateTime.parse(json['lastCompleted']).toLocal()
          : null,
      nextDue: DateTime.parse(json['nextDue']).toLocal(),
      reminderTime: timeOfDayFromString(json['reminderTime']),
      owner: User.fromJson(json['owner']),
      users: json['users'] != null
          ? List<User>.from(json['users'].map((u) => User.fromJson(u)))
          : [],
      customDays: json['customDays'] != null
          ? (json['customDays'] as String).split(',')
          : [],
      isPublic: json['isPublic'] ?? false,
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'target': goal,
      'frequency': frequency,
      'reminderTime': timeOfDayToString(reminderTime),
      'icon': icon.codePoint.toString(),
      'iconFontFamily': iconFontFamily,
      'color': color.value.toRadixString(16),
      'startDate': createdAt.toIso8601String(),
      'customDays': customDays.join(','),
      'isPublic': isPublic,
    };
  }

  static Habit copyWith(Habit habit, Map<String, dynamic> updates) {
    return Habit(
      id: updates['id'] ?? habit.id,
      name: updates['name'] ?? habit.name,
      description: updates['description'] ?? habit.description,
      icon: updates['icon'] != null
          ? iconDataFromString(updates['icon'], updates['iconFontFamily'])
          : habit.icon,
      iconFontFamily: updates['iconFontFamily'] ?? habit.iconFontFamily,
      color: updates['color'] != null
          ? Color(int.parse(updates['color'], radix: 16))
          : habit.color,
      streak: updates['streak'] ?? habit.streak,
      goal: updates['goal'] ?? habit.goal,
      time: updates['time'] ?? habit.time,
      frequency: updates['frequency'] ?? habit.frequency,
      lastCompleted: updates['lastCompleted'] != null
          ? DateTime.parse(updates['lastCompleted'])
          : habit.lastCompleted,
      nextDue: updates['nextDue'] != null
          ? DateTime.parse(updates['nextDue'])
          : habit.nextDue,
      reminderTime: updates['reminderTime'] != null
          ? timeOfDayFromString(updates['reminderTime'])
          : habit.reminderTime,
      owner: updates['owner'] != null
          ? User.fromJson(updates['owner'])
          : habit.owner,
      users: updates['users'] != null
          ? List<User>.from(updates['users'].map((u) => User.fromJson(u)))
          : habit.users,
      customDays: updates['customDays'] != null
          ? (updates['customDays'])
          : habit.customDays,
      isPublic: updates['isPublic'] ?? habit.isPublic,
      createdAt: updates['createdAt'] != null
          ? DateTime.parse(updates['createdAt'])
          : habit.createdAt,
      updatedAt: updates['updatedAt'] != null
          ? DateTime.parse(updates['updatedAt'])
          : habit.updatedAt,
    );
  }
}

class HabitInvite {
  int id;
  User userInvited;
  Habit habit;
  bool accepted;
  DateTime createdAt;
  DateTime updatedAt;

  HabitInvite({
    required this.id,
    required this.userInvited,
    required this.habit,
    required this.accepted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HabitInvite.fromJson(Map<String, dynamic> json) {
    return HabitInvite(
      id: json['id'],
      userInvited: User.fromJson(json['userInvited']),
      habit: Habit.fromJson(json['habit']),
      accepted: json['accepted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
