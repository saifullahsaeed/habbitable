import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/notification.dart';
import 'package:habbitable/widgets/mainappbar.dart';
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
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
                  child: ListView.builder(
                itemCount: NotificationCategory.values.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    Chip(label: Text(NotificationCategory.values[index].name)),
              ))),
        ],
      ),
    );
  }
}
