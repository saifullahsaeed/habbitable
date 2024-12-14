import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/post_controller.dart';
import 'package:habbitable/screens/community/club/widgets/coment_input.dart';
import 'package:habbitable/screens/community/club/widgets/comment.dart';
import 'package:habbitable/screens/community/club/widgets/post_actions_bar.dart';
import 'package:habbitable/screens/community/club/widgets/post_content.dart';
import 'package:habbitable/screens/community/club/widgets/post_header.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Post",
        showLogo: false,
        showNotifications: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.comments.length +
                    2, // Post content (1) + comments (10)
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PostHeader(
                          showMenu: false,
                          club: controller.post.club,
                          user: controller.post.user,
                          time: controller.post.createdAt,
                        ),
                        PostContent(
                          content: controller.post.content,
                          hashtags: controller.post.hashtags,
                          links: controller.post.links,
                          mentions: controller.post.mentions,
                          post: controller.post,
                        ),
                        const SizedBox(height: 10),
                        PostActionsBar(post: controller.post),
                        const SizedBox(height: 10),
                        Divider(
                          color: Get.theme.colorScheme.outlineVariant
                              .withOpacity(0.1),
                          height: 1,
                        ),
                      ],
                    );
                  }
                  // Return comments for the remaining items
                  if (index <= controller.comments.length) {
                    if (controller.isCommentsLoading.value) {
                      return const SizedBox.shrink();
                    }
                    return Comment(
                      comment: controller.comments[index - 1],
                      postController: controller,
                    );
                  }
                  if (index == controller.comments.length + 1 &&
                      controller.comments.isNotEmpty &&
                      controller.comments.length > controller.limit) {
                    return TextButton(
                      onPressed: () {},
                      child: Text("Load more",
                          style: Get.textTheme.bodySmall!.copyWith(
                            color: Get.theme.colorScheme.primary,
                          )),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          CommentInput(
            postId: controller.post.id.toString(),
            clubId: controller.post.clubId.toString(),
            focusNode: controller.commentFocusNode,
            onSubmit: controller.postComment,
            postController: controller,
          ),
        ],
      ),
    );
  }
}
