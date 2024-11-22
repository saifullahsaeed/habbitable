import 'package:habbitable/models/user.dart';

class HabitLog {
  final int? id;
  final User? user;
  final DateTime? date;
  final String action;
  final HabitLog? reversedLog;
  final int habitId;
  final bool? isLate;
  final String? note;

  HabitLog({
    this.id,
    this.user,
    this.date,
    required this.action,
    this.reversedLog,
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
      reversedLog: json['reversed_log'] != null
          ? HabitLog.fromJson(json['reversed_log'])
          : null,
      habitId: json['habit_id'] ?? json['habit']['id'],
      isLate: json['isLate'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'habitId': habitId,
      'note': note,
    };
  }
}
