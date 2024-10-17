import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loadAction(Future<dynamic> action) async {
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
  );
  await action;
  Get.back();
}
