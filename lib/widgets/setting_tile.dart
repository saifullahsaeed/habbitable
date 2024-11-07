import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      splashColor: Get.theme.primaryColor.withOpacity(0.1),
      onTap: onTap,
      tileColor: Get.theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      leading: Icon(
        icon,
        color: Get.theme.primaryColor,
      ),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
