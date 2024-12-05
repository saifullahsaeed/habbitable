class ImageModel {
  int id;
  int userId;
  String url;
  String mimeType;
  DateTime createdAt;
  DateTime updatedAt;

  ImageModel({
    required this.id,
    required this.userId,
    required this.url,
    required this.mimeType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        userId: json["userId"],
        url: json["url"],
        mimeType: json["mimeType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
