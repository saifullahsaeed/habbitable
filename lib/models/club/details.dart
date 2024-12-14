import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/habit.dart';

class ClubDetails {
  Club club;
  List<Habit> habits;
  int totalMembers;
  int habitsCount;
  int noOfPosts;

  ClubDetails({
    required this.club,
    required this.habits,
    required this.totalMembers,
    required this.habitsCount,
    required this.noOfPosts,
  });

  factory ClubDetails.fromJson(Map<String, dynamic> json) => ClubDetails(
        club: Club.fromJson(json["club"]),
        habits:
            json["habits"].map((h) => Habit.fromJson(h)).toList().cast<Habit>(),
        totalMembers: json["totalMembers"] ?? 0,
        habitsCount: json["habitsCount"] ?? 0,
        noOfPosts: json["noOfPosts"] ?? 0,
      );
}
