import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/comment.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:line_icons/line_icons.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;
  final bool isReply;
  const Comment({
    super.key,
    required this.comment,
    this.isReply = false,
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
                  Row(
                    children: [
                      Icon(
                        LineIcons.comments,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.comment.replyCount} replies",
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // if (showReplies)
          //   Container(
          //     margin: const EdgeInsets.only(left: 10),
          //     child: ListView.builder(
          //       shrinkWrap: true,
          //       physics: const NeverScrollableScrollPhysics(),
          //       itemCount: (widget.comment["subComments"] ?? []).length,
          //       itemBuilder: (context, index) {
          //         return CommentReply(
          //             reply: widget.comment["subComments"][index]);
          //       },
          //     ),
          //   ),
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
