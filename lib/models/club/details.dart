import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/habit.dart';

class ClubDetails {
  Club club;
  List<Habit> habits;
  int membersCount;
  int habitsCount;

  ClubDetails({
    required this.club,
    required this.habits,
    required this.membersCount,
    required this.habitsCount,
  });

  factory ClubDetails.fromJson(Map<String, dynamic> json) => ClubDetails(
        club: Club.fromJson(json["club"]),
        habits: json["habits"].map((h) => Habit.fromJson(h)).toList(),
        membersCount: json["membersCount"],
        habitsCount: json["habitsCount"],
      );
}
