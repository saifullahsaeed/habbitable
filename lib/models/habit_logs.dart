import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/user.dart';

class HabitLog {
  final int? id;
  final User? user;
  final DateTime? date;
  final String action;
  final Habit? habit;
  final int habitId;
  final bool? isLate;
  final String? note;

  HabitLog({
    this.id,
    this.user,
    this.date,
    required this.action,
    this.habit,
    required this.habitId,
    this.isLate,
    this.note,
  });

  factory HabitLog.fromJson(Map<String, dynamic> json) {
    return HabitLog(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      action: json['action'],
      habit: json['habit'] != null ? Habit.fromJson(json['habit']) : null,
      habitId: json['habit_id'] ?? json['habit']['id'],
      isLate: json['isLate'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'habit_id': habitId,
      'note': note,
    };
  }
}
