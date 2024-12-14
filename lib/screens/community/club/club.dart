import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/club_controller.dart';
import 'package:line_icons/line_icons.dart';

class ClubScreen extends GetView<ClubController> {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: "club_header_${controller.clubId}",
              child: Visibility(
                visible: controller.appBarTitleVisible.value,
                maintainAnimation: true,
                maintainState: true,
                child: Text(
                  controller.clubDetails.value?.club.name ?? "Club",
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
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
                  Icons.more_vert,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  LineIcons.share,
                  size: 20,
                ),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: controller.feed.length,
            controller: controller.scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: controller.feed[index],
              );
            },
          ),
        );
      },
    );
  }
}
