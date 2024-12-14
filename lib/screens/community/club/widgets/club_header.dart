import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/club_controller.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

class ClubScreenHeader extends StatefulWidget {
  final ClubController controller;
  const ClubScreenHeader({super.key, required this.controller});

  @override
  State<ClubScreenHeader> createState() => _ClubScreenHeaderState();
}

class _ClubScreenHeaderState extends State<ClubScreenHeader> {
  ClubController get controller => widget.controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: controller.isClubLoading.value
            ? Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.clubDetails.value?.club.name ?? "",
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.clubDetails.value?.club.description ?? "",
                    style: Get.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  text: controller
                                          .clubDetails.value?.totalMembers
                                          .toString() ??
                                      "0",
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: controller.clubDetails.value
                                              ?.totalMembers ==
                                          1
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
                            LineIcons.comments,
                            size: 15,
                            color: Get.theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: controller.clubDetails.value?.noOfPosts
                                          .toString() ??
                                      "0",
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      controller.clubDetails.value?.noOfPosts ==
                                              1
                                          ? " post"
                                          : " posts",
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
                                  text: controller
                                          .clubDetails.value?.habitsCount
                                          .toString() ??
                                      "0",
                                  style: Get.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: controller
                                              .clubDetails.value?.habitsCount ==
                                          1
                                      ? " habit"
                                      : " habits",
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LineIcons.filter,
                          size: 15,
                          color: Get.theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Filter",
                          style: Get.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Get.theme.colorScheme.primary.withOpacity(0.5),
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        controller.user.value?.avatar != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  controller.user.value!.avatar!.url,
                                ),
                              )
                            : InitialsImagePlaceholder(
                                name: controller.user.value!.name,
                                radius: 16,
                              ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                '/club/${controller.clubId}/newpost',
                                arguments: {
                                  'clubId': controller.clubId,
                                  'clubDetails': controller.clubDetails.value,
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Get.theme.cardColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                "Write your thoughts here...",
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
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
