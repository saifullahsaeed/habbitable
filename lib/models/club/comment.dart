import 'package:habbitable/models/user.dart';

class CommentModel {
  int id;
  int postId;
  int userId;
  String? content;
  String? gif;
  String? parentId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  int likeCount;
  int replyCount;
  bool isLiked;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    this.content,
    this.gif,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.likeCount,
    required this.replyCount,
    required this.isLiked,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
      gif: json['gif'],
      parentId: json['parentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
      likeCount: json['likeCount'] ?? 0,
      replyCount: json['replyCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
    );
  }

  CommentModel copyWith({
    int? id,
    int? postId,
    int? userId,
    String? content,
    String? gif,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    int? likeCount,
    int? replyCount,
    bool? isLiked,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      gif: gif ?? this.gif,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      likeCount: likeCount ?? this.likeCount,
      replyCount: replyCount ?? this.replyCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
