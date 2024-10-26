import 'package:flutter/material.dart';
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
  final String rate;
  DateTime? lastCompleted;
  DateTime nextDue;
  final DateTime reminderTime;
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
    required this.rate,
    this.lastCompleted,
    required this.nextDue,
    required this.reminderTime,
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
          ? iconDataFromString(json['icon'], json['icon_font_family'])
          : Icons.star,
      iconFontFamily: json['icon_font_family'] ?? "MaterialIcons",
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.blue,
      streak: json['streak'],
      goal: json['goal'],
      time: json['time'],
      rate: json['rate'],
      lastCompleted: json['lastCompleted'] != null
          ? DateTime.parse(json['lastCompleted'])
          : null,
      nextDue: DateTime.parse(json['nextDue']),
      reminderTime: DateTime.parse(json['reminder_time']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon': icon.codePoint,
      'icon_font_family': iconFontFamily,
      'color': color.value.toRadixString(16),
      'goal': goal,
      'time': time,
      'rate': rate,
      'reminder_time': reminderTime.toIso8601String(),
    };
  }
}
