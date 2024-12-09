import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/post.dart';
import 'package:habbitable/screens/community/club/widgets/post_actions_bar.dart';
import 'package:habbitable/screens/community/club/widgets/post_content.dart';
import 'package:habbitable/screens/community/club/widgets/post_header_home.dart';

class PostCardHome extends StatelessWidget {
  final Post post;
  const PostCardHome({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.outlineVariant.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomePostHeader(
            club: post.club,
            user: post.user,
            time: post.createdAt,
          ),
          const SizedBox(height: 10),
          PostContent(
            content: post.content,
            hashtags: post.hashtags,
            links: post.links,
            mentions: post.mentions,
            post: post,
          ),
          const SizedBox(height: 10),
          PostActionsBar(post: post),
          const SizedBox(height: 10),
          // Divider(
          //   color: Get.theme.colorScheme.outlineVariant.withOpacity(0.1),
          //   height: 1,
          // ),
          // top comment
          // Comment(),
        ],
      ),
    );
  }
}
