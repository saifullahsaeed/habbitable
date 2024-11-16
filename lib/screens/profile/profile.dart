import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/profile/controllers/profilecontroller.dart';
import 'package:habbitable/screens/profile/widgets/action_buttons.dart';
import 'package:habbitable/screens/profile/widgets/profile_options.dart';
import 'package:habbitable/screens/profile/widgets/profile_tabs.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                title: Text(controller.profile.value.name,
                    style: Get.textTheme.titleMedium),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (context) => ProfileOptions(
                            context: context,
                            reportController: controller.reportController),
                      );
                    },
                    icon: const Icon(Icons.more_vert_outlined),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Center(
                              child: InitialsImagePlaceholder(
                                name: controller.profile.value.name,
                                radius: 50,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(controller.profile.value.name,
                                style: Get.textTheme.titleMedium),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${controller.profile.value.totalHabitsCount}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.profile.value.habits.length > 1
                                          ? 'Habits'
                                          : 'Habit',
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${controller.profile.value.totalFriendsCount}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.profile.value.friends.length >
                                              1
                                          ? 'Friends'
                                          : 'Friend',
                                      style: Get.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ActionButtons(
                              isMyProfile: controller.isMyProfile,
                              isFriend: controller.profile.value.isFriend,
                              requestSent: controller.profile.value.requestSent,
                              requestReceived:
                                  controller.profile.value.requestReceived,
                              onSendRequest: controller.sendRequest,
                              onRejectRequest: controller.rejectRequest,
                              onAcceptRequest: controller.acceptRequest,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ProfileTabs(
                          habits: controller.profile.value.habits,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
