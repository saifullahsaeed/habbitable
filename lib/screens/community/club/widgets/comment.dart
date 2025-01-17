import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/comment.dart';
import 'package:habbitable/screens/community/club/controllers/post_controller.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:line_icons/line_icons.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;
  final bool isReply;
  final bool showActions;
  final PostController? postController;
  final bool showReplyOptions;
  const Comment({
    super.key,
    required this.comment,
    this.isReply = false,
    this.showActions = true,
    this.postController,
    this.showReplyOptions = true,
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool showReplies = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        widget.comment.user.avatar?.url ?? "",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            timeAgo(widget.comment.createdAt),
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.outlineVariant,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            widget.comment.content ?? "",
            style: Get.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          if (widget.showActions)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        LineIcons.heart,
                        size: 15,
                        color: Get.theme.colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.comment.likeCount.toString(),
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  if (!widget.isReply)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showReplies = !showReplies;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            LineIcons.comments,
                            size: 15,
                            color: Get.theme.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${widget.comment.replyCount} replies",
                            style: Get.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 10),
                  if (widget.showReplyOptions)
                    GestureDetector(
                      onTap: () {
                        widget.postController
                            ?.openInputForReply(widget.comment);
                      },
                      child: Text(
                        "Reply to ${widget.comment.user.name}",
                        style: Get.textTheme.bodySmall!.copyWith(
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (showReplies)
            Obx(() {
              if (widget.postController?.commentsReplies.value.isNotEmpty ??
                  false) {
                if (widget.postController?.commentsReplies.value
                        .firstWhereOrNull((element) =>
                            element.containsKey(widget.comment.id.toString()))
                        ?.isNotEmpty ??
                    false) {
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.postController?.commentsReplies.value
                              .firstWhereOrNull((element) => element
                                  .containsKey(widget.comment.id.toString()))
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return CommentReply(
                          reply: widget.postController?.commentsReplies.value
                                  .firstWhereOrNull((element) =>
                                      element.containsKey(
                                          widget.comment.id.toString()))
                                  ?.values
                                  .first[index] ??
                              widget.comment,
                        );
                      },
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            }),
        ],
      ),
    );
  }
}

class CommentReply extends StatelessWidget {
  final CommentModel reply;
  const CommentReply({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Comment(comment: reply, isReply: false),
    );
  }
}
