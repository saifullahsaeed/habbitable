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

  Future<void> postComment(String clubId, String postId, String content) async {
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
    await clubService.postComment(clubId, postId, content);
  }
}
