import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({
  required String title,
  required String message,
  String type = 'info',
  int duration = 3,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    margin: const EdgeInsets.all(15),
    borderRadius: 8,
    forwardAnimationCurve: Curves.easeOutQuint,
    reverseAnimationCurve: Curves.easeInQuint,
    backgroundColor: type == 'info'
        ? Colors.blue.shade600
        : type == 'error'
            ? Colors.red.shade600
            : type == 'success'
                ? Colors.green.shade600
                : Colors.blue.shade600,
    boxShadows: [
      BoxShadow(
        color: Get.theme.colorScheme.onSurface.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    colorText: Get.theme.colorScheme.onPrimary,
    titleText: Text(
      title,
      style: Get.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: Get.theme.colorScheme.onPrimary,
      ),
    ),
    messageText: Text(
      message,
      style: Get.textTheme.bodySmall!.copyWith(
        color: Get.theme.colorScheme.onPrimary,
      ),
    ),
    duration: Duration(seconds: duration),
  );
}
