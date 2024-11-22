import 'package:habbitable/models/friend.dart';
import 'package:habbitable/models/habit.dart';

class Profile {
  final int id;
  final String name;
  final int? age;
  final DateTime createdAt;
  final List<Habit> habits;
  final List<Friend> friends;
  final int totalFriendsCount;
  final int totalHabitsCount;
  bool isFriend;
  bool requestSent;
  bool requestReceived;

  Profile(
      {required this.id,
      required this.name,
      required this.age,
      required this.createdAt,
      required this.habits,
      required this.friends,
      required this.totalFriendsCount,
      required this.totalHabitsCount,
      required this.isFriend,
      required this.requestSent,
      required this.requestReceived});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        createdAt: DateTime.parse(json['createdAt']),
        habits: json['habits'] != null
            ? List<Habit>.from(
                (json['habits'] as List).map((habit) => Habit.fromJson(habit)))
            : [],
        friends: json['friends'] != null
            ? List<Friend>.from((json['friends'] as List)
                .map((friend) => Friend.fromJson(friend)))
            : [],
        totalFriendsCount: json['totalFriendsCount'] ?? 0,
        totalHabitsCount: json['totalHabitsCount'] ?? 0,
        isFriend: json['friend'] ?? false,
        requestSent: json['requestSent'] ?? false,
        requestReceived: json['requestReceived'] ?? false,
      );

  static Profile empty() => Profile(
        id: 0,
        name: '',
        age: 0,
        createdAt: DateTime.now(),
        habits: [],
        friends: [],
        totalFriendsCount: 0,
        totalHabitsCount: 0,
        isFriend: false,
        requestSent: false,
        requestReceived: false,
      );
}
