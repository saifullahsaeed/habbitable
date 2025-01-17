import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/screens/community/club/controllers/join_club.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:line_icons/line_icons.dart';

class JoinClubScreen extends GetView<JoinClubController> {
  final Club club;
  const JoinClubScreen({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            LineIcons.arrowLeft,
            size: 25,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              LineIcons.share,
              size: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, // Height for the cover image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(club.image?.url ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: club.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        if (club.isVerified)
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.verified,
                                size: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              club.description,
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      LineIcons.users,
                      size: 15,
                      color: Get.theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: club.numberOfMembers.toString(),
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: club.numberOfMembers == 1
                                ? " member"
                                : " members",
                            style: Get.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      LineIcons.fire,
                      size: 15,
                      color: Get.theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: club.noOfHabits.toString(),
                            style: Get.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: club.noOfHabits == 1 ? " habit" : " habits",
                            style: Get.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: Get.width,
              child: Obx(() {
                return MainButton(
                  label:
                      controller.isLoading.value ? "Joining..." : "Join Club",
                  onPressed: () async {
                    bool isJoined = await controller.joinClub();
                    if (isJoined) {
                      Get.offAndToNamed('/club/${club.id}');
                    }
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Note: ",
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "By joining this club, you agree to the Habbitable's ",
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: "terms and conditions ",
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //open terms and conditions
                        debugPrint("open terms and conditions");
                      },
                  ),
                  TextSpan(
                    text: "for public communities.",
                    style: Get.textTheme.bodySmall!.copyWith(
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
