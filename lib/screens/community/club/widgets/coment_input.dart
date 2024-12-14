import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/post_controller.dart';
import 'package:line_icons/line_icons.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  final String clubId;
  final Function(String, String, String) onSubmit;
  final FocusNode focusNode;
  final PostController? postController;
  const CommentInput({
    super.key,
    required this.postId,
    required this.clubId,
    required this.onSubmit,
    required this.focusNode,
    this.postController,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() {
            if (widget.postController?.replyingToComment.value != null) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Replying to ",
                            style: Get.textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: widget.postController?.replyingToComment.value
                                    ?.user.name ??
                                "",
                            style: Get.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.postController?.cancelReply();
                      },
                      icon: const Icon(Icons.close, size: 10),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.gif_outlined),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onSubmitted: (value) {
                    widget.onSubmit(widget.clubId, widget.postId, value);
                    _controller.clear();
                  },
                  enableSuggestions: true,
                  maxLength: 250,
                  maxLines: 3,
                  minLines: 1,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Add a comment",
                    hintStyle: Get.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.outlineVariant,
                    ),
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Get.theme.colorScheme.outlineVariant
                            .withOpacity(0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Get.theme.colorScheme.outlineVariant,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Get.theme.colorScheme.outlineVariant
                            .withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.focusNode.unfocus();
                  widget.onSubmit(
                      widget.clubId, widget.postId, _controller.text);

                  _controller.clear();
                },
                icon: const Icon(
                  LineIcons.paperPlaneAlt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
