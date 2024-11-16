import 'package:habbitable/models/user.dart';

class Friend {
  final int id;
  final User userOne;
  final User userTwo;
  final DateTime createdAt;

  Friend(
      {required this.id,
      required this.userOne,
      required this.userTwo,
      required this.createdAt});

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json['id'],
        userOne: User.fromJson(json['userOne']),
        userTwo: User.fromJson(json['userTwo']),
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userOne': userOne.toJson(),
        'userTwo': userTwo.toJson(),
        'createdAt': createdAt.toIso8601String(),
      };
  static User otherUser(Friend friend, int me) =>
      friend.userOne.id == me ? friend.userTwo : friend.userOne;
}

class FriendRequest {
  final int id;
  final String status;
  final DateTime createdAt;
  final User addressee;
  final User requester;

  FriendRequest(
      {required this.id,
      required this.status,
      required this.createdAt,
      required this.addressee,
      required this.requester});

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        id: json['id'],
        status: json['status'],
        createdAt: DateTime.parse(json['createdAt']),
        addressee: User.fromJson(json['addressee']),
        requester: User.fromJson(json['requester']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'addressee': addressee.toJson(),
        'requester': requester.toJson(),
      };
}
