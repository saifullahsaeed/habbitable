import 'package:flutter/material.dart';
import 'package:habbitable/utils/functions.dart';

class Habit {
  final String id;
  final String name;
  final String? description;
  final IconData icon;
  final Color color;
  int streak;
  final int goal;
  final int time;
  final String rate;
  DateTime lastCompleted;
  DateTime nextDue;
  final bool isOnProbation;
  final DateTime createdAt;
  final DateTime updatedAt;

  Habit({
    required this.id,
    required this.name,
    this.description,
    this.icon = Icons.star,
    this.color = Colors.blue,
    required this.streak,
    required this.goal,
    required this.time,
    required this.rate,
    required this.lastCompleted,
    required this.nextDue,
    required this.isOnProbation,
    required this.createdAt,
    required this.updatedAt,
  });

  bool isCompleted() {
    return lastCompleted.day == DateTime.now().day;
  }

  bool isDelayed() {
    return nextDue.isBefore(
        DateTime.now().copyWith(minute: 0, second: 0, millisecond: 0));
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon:
          json['icon'] != null ? iconDataFromString(json['icon']) : Icons.star,
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.blue,
      streak: json['streak'],
      goal: json['goal'],
      time: json['time'],
      rate: json['rate'],
      lastCompleted: DateTime.parse(json['lastCompleted']),
      nextDue: DateTime.parse(json['nextDue']),
      isOnProbation: json['isOnProbation'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon': icon.codePoint,
      'color': color.value.toRadixString(16),
      'goal': goal,
      'time': time,
      'rate': rate,
      'lastCompleted': lastCompleted.toIso8601String(),
      'nextDue': nextDue.toIso8601String(),
    };
  }
}
