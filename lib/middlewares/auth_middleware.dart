import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = Get.find<LocalStorageService>().isAuthenticated;
    if (!isAuthenticated) {
      return const RouteSettings(name: '/auth');
    }
    return null;
  }
}
