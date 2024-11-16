class User {
  final int id;
  final String name;
  final String email;
  final int? age;
  final String? gender;
  final bool? friend;
  final bool? sentRequest;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.gender,
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
    };
  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }

  // Create a User from a JSON object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
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
