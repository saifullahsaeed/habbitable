import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/post.dart';

class PostContent extends StatelessWidget {
  final String content;
  final List<String> hashtags;
  final List<String> links;
  final List<String> mentions;
  final Post post;
  const PostContent({
    super.key,
    required this.content,
    required this.hashtags,
    required this.links,
    required this.mentions,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/club/1/post', arguments: {'post': post});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Markdown(
            data: content,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            styleSheet: MarkdownStyleSheet(
              p: Get.textTheme.bodyMedium,
            ),
            selectable: true,
            onTapText: () {
              Get.toNamed('/club/1/post', arguments: {'post': post});
            },
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
