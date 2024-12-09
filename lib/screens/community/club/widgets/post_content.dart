import 'package:flutter/material.dart';
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
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: Get.textTheme.bodyMedium,
          children: _buildTextSpans(),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];

    // Split content by spaces to process each word
    List<String> words = content.split(' ');

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      // Check if the word is a hashtag
      if (hashtags.any((tag) => word.toLowerCase() == '#$tag'.toLowerCase())) {
        spans.add(TextSpan(
          text: '$word ',
          style: Get.textTheme.bodyMedium!.copyWith(
            color: Get.theme.colorScheme.primary,
          ),
        ));
      } else {
        spans.add(TextSpan(text: '$word '));
      }
    }

    // Add the hashtags section at the bottom
    if (hashtags.isNotEmpty) {
      spans.add(const TextSpan(text: '\n\n'));
      spans.add(TextSpan(
        text: hashtags.map((e) => "#$e").join(" "),
        style: Get.textTheme.bodyMedium!.copyWith(
          color: Get.theme.colorScheme.primary,
        ),
      ));
    }

    return spans;
  }
}
