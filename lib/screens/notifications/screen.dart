import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/notifications/widgets/notification_tile.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:line_icons/line_icons.dart';

import 'controllers/controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Notifications',
        showBackButton: true,
        showNotifications: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              LineIcons.filter,
              size: 22,
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.notifications.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => NotificationItem(
                  notification: controller.notifications[index],
                  controller: controller,
                ),
              ),
      ),
    );
  }
}
