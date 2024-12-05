import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? showBackButton;
  final bool? showNotifications;
  final bool? showLogo;
  final bool? showTitle;
  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton,
    this.showNotifications = true,
    this.showLogo = false,
    this.showTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Get.theme.colorScheme.primary,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLogo ?? false)
              Image.asset(
                'assets/images/logo.png',
                width: 25,
                height: 25,
              ),
            if (showLogo ?? false) const SizedBox(width: 8),
            if (showTitle ?? true)
              Text(
                title ?? "Habbitable",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
          ],
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
