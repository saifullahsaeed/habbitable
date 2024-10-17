import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({
  required String title,
  required String message,
  String type = 'info',
  int duration = 3,
}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      backgroundColor: type == 'info'
          ? Colors.blue
          : type == 'error'
              ? Colors.red.withOpacity(0.8)
              : type == 'success'
                  ? Colors.green.withOpacity(0.8)
                  : Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: Duration(seconds: duration));
}
