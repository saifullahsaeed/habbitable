import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? showBackButton;
  final bool? showNotifications;
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton,
    this.showNotifications = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Get.theme.colorScheme.primary,
        title: Text(
          title ?? "Habbitable",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (showNotifications ?? false)
            IconButton(
              onPressed: () {
                Get.toNamed('/notifications');
              },
              icon: const Icon(Icons.notifications_none),
            ),
          ...actions ?? [],
        ],
      );
}
