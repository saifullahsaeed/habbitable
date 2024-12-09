import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/post.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:line_icons/line_icons.dart';

class PostActionsBar extends StatefulWidget {
  final Post post;

  const PostActionsBar({
    super.key,
    required this.post,
  });

  @override
  State<PostActionsBar> createState() => _PostActionsBarState();
}

class _PostActionsBarState extends State<PostActionsBar> {
  bool isLiked = false;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isLiked;
    likesCount = widget.post.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                isLiked = !isLiked;
                likesCount = isLiked ? likesCount + 1 : likesCount - 1;
              });
              Get.find<CommunityController>()
                  .likePost(widget.post.clubId, widget.post.id);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color:
                        Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$likesCount ${likesCount == 1 ? "Like" : "Likes"}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () {
              if (Get.routeTree.routes.last.name !=
                  '/club/${widget.post.clubId}/post') {
                Get.toNamed(
                  '/club/${widget.post.clubId}/post',
                  arguments: {
                    'post': widget.post,
                    'focusComment': true,
                  },
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color:
                        Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LineIcons.comments),
                  const SizedBox(width: 5),
                  Text(
                    "${widget.post.commentsCount} ${widget.post.commentsCount == 1 ? "Comment" : "Comments"}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
