import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/comment.dart';
import 'package:habbitable/models/club/post.dart';

class PostController extends GetxController {
  late Post post;
  final ClubsService clubService = ClubsService();
  RxList<CommentModel> comments = RxList<CommentModel>();
  final GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  FocusNode commentFocusNode = FocusNode();
  RxBool isCommentsLoading = false.obs;
  Rx<CommentModel?> replyingToComment = Rx<CommentModel?>(null);
  Rx<List<Map<String, List<CommentModel>>>> commentsReplies =
      Rx<List<Map<String, List<CommentModel>>>>([]);
  int limit = 10;
  int offset = 0;

  @override
  void onInit() {
    post = Get.arguments['post'];
    if (Get.arguments['focusComment'] == true) {
      commentFocusNode.requestFocus();
    }
    getPostComments(post.clubId.toString(), post.id.toString());
    super.onInit();
  }

  Future<void> getPostComments(String clubId, String postId) async {
    isCommentsLoading.value = true;
    comments.value =
        await clubService.getPostComments(clubId, postId, limit, offset);
    isCommentsLoading.value = false;
  }

  Future<void> loadMoreComments() async {
    offset += limit;
    getPostComments(post.clubId.toString(), post.id.toString());
  }

  Future<CommentModel> replyToCommentAction(
    CommentModel parentComment,
    String content,
  ) async {
    replyingToComment.value = parentComment;
    final CommentModel reply = CommentModel(
      content: content,
      createdAt: DateTime.now(),
      id: 0,
      parentId: parentComment.id.toString(),
      postId: int.parse(post.id.toString()),
      replyCount: 0,
      updatedAt: DateTime.now(),
      userId: authService.currentUser.id,
      user: authService.currentUser,
      isLiked: false,
      likeCount: 0,
    );
    commentsReplies.value.first[parentComment.id.toString()] = [reply];
    clubService.replyToComment(post.clubId.toString(), post.id.toString(),
        parentComment.id.toString(), content);

    return reply;
  }

  Future<CommentModel> postComment(
      String clubId, String postId, String content) async {
    if (replyingToComment.value != null) {
      return await replyToCommentAction(replyingToComment.value!, content);
    } else {
      final CommentModel comment = CommentModel(
        content: content,
        createdAt: DateTime.now(),
        id: 0,
        likeCount: 0,
        postId: int.parse(postId),
        replyCount: 0,
        updatedAt: DateTime.now(),
        userId: authService.currentUser.id,
        user: authService.currentUser,
        isLiked: false,
      );
      comments.insert(0, comment);
      clubService.postComment(clubId, postId, content);
      return comment;
    }
  }

  void cancelReply() {
    replyingToComment.value = null;
  }

  void openInputForReply(CommentModel comment) {
    replyingToComment.value = comment;
    commentFocusNode.requestFocus();
  }
}
