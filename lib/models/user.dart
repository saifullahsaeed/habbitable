import 'package:habbitable/models/image.dart';

class User {
  final int id;
  final String name;
  final String email;
  final int? age;
  final String? gender;
  final ImageModel? avatar;
  final bool? friend;
  final bool? sentRequest;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.gender,
    this.avatar,
    this.friend = false,
    this.sentRequest = false,
  });

  // Convert a User into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'avatar': avatar?.toJson(),
    };
  }

  // Create a User from a JSON object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      avatar:
          json['avatar'] != null ? ImageModel.fromJson(json['avatar']) : null,
      friend: json['friend'] ?? false,
      sentRequest: json['sentRequest'] ?? false,
    );
  }
}

class SignupModel {
  final String name;
  final String email;
  final String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
