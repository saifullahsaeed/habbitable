import 'package:habbitable/models/club/catagory.dart';
import 'package:habbitable/models/image.dart';
import 'package:habbitable/models/user.dart';

class Club {
  int id;
  String name;
  String description;
  int? imageId;
  String slug;
  bool isPrivate;
  bool isVerified;
  bool isActive;
  bool isArchived;
  int ownerId;
  DateTime createdAt;
  DateTime updatedAt;
  ImageModel? image;
  User owner;
  int? numberOfMembers;
  int? noOfHabits;
  Catagory? catagory;
  bool isMember;

  Club({
    required this.id,
    required this.name,
    required this.description,
    this.imageId,
    required this.slug,
    required this.isPrivate,
    required this.isVerified,
    required this.isActive,
    required this.isArchived,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    required this.owner,
    this.numberOfMembers,
    this.noOfHabits,
    this.catagory,
    this.isMember = false,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageId: json["imageId"],
        slug: json["slug"],
        isPrivate: json["isPrivate"],
        isVerified: json["isVerified"],
        isActive: json["isActive"],
        isArchived: json["isArchived"],
        ownerId: json["ownerId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image:
            json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
        owner: User.fromJson(json["owner"]),
        numberOfMembers: json["noOfMembers"] ?? 0,
        noOfHabits: json["noOfHabits"] ?? 0,
        catagory: json["catagory"] != null
            ? Catagory.fromJson(json["catagory"])
            : null,
        isMember: json["isMember"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "imageId": imageId,
        "isPrivate": isPrivate,
      };
}
