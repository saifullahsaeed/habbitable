import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Obx(() => ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) =>
              Text(controller.notifications[index].title))),
    );
  }
}
