import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/utils/functions.dart';

class PostHeader extends StatelessWidget {
  final bool showMenu;
  final Club club;
  final User user;
  final DateTime time;
  const PostHeader({
    super.key,
    required this.club,
    required this.user,
    required this.time,
    this.showMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Get.theme.colorScheme.surface,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://cdn.habbitable.com/1733366121509-133184403.jpg",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Get.textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: user.name,
                              style: Get.textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " ",
                            ),
                            TextSpan(
                              text: "added a new post",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        timeAgo(time),
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showMenu)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
    );
  }
}
