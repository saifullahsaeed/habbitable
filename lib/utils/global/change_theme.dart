import 'package:flutter/material.dart';
import 'package:get/get.dart';

int toggleTheme() {
  Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  Get.isDarkMode == true;
  return Get.isDarkMode ? 0 : 1;
}
