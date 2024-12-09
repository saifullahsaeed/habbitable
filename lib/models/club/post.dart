import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/club/comment.dart';
import 'package:habbitable/models/user.dart';

class Post {
  final int id;
  final int clubId;
  final int userId;
  final String content;
  final bool isEdited;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Club club;
  final User user;
  final List<String> mentions;
  final List<String> hashtags;
  final List<String> links;
  final int likesCount;
  final int commentsCount;
  final int? topCommentId;
  final CommentModel? topComment;
  bool isLiked;

  Post({
    required this.id,
    required this.clubId,
    required this.userId,
    required this.content,
    required this.isEdited,
    required this.createdAt,
    required this.updatedAt,
    required this.club,
    required this.user,
    required this.mentions,
    required this.hashtags,
    required this.links,
    required this.likesCount,
    required this.commentsCount,
    this.topCommentId,
    this.topComment,
    required this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      clubId: json["clubId"],
      userId: json["userId"],
      content: json["content"],
      isEdited: json["isEdited"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      club: Club.fromJson(json["club"]),
      user: User.fromJson(json["user"]),
      mentions: List<String>.from(json["mentions"]),
      hashtags: List<String>.from(json["hashtags"]),
      links: List<String>.from(json["links"]),
      likesCount: json["likesCount"],
      commentsCount: json["commentsCount"],
      topCommentId: json["topCommentId"],
      topComment: json["topComment"] != null
          ? CommentModel.fromJson(json["topComment"])
          : null,
      isLiked: json["isLiked"],
    );
  }
}
