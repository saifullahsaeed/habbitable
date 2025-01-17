class Catagory {
  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Catagory({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Catagory.fromJson(Map<String, dynamic> json) {
    return Catagory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
