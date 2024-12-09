import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/utils/functions.dart';

class HomePostHeader extends StatelessWidget {
  final Club club;
  final User user;
  final DateTime time;
  const HomePostHeader({
    super.key,
    required this.club,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.colorScheme.surface,
                image: DecorationImage(
                  image: NetworkImage(
                    club.image?.url ?? "",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 3,
              bottom: 3,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://cdn.habbitable.com/thumb-1920-1345029.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                club.name,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                    TextSpan(
                      text: " posted a new post",
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
    );
  }
}
