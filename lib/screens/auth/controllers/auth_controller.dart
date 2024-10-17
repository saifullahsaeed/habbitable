import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';

class AuthController extends GetxController {
  final GlobalAuthenticationService _auth =
      Get.find<GlobalAuthenticationService>();

  //login form key
  final loginFormKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
    try {
      await _auth.login(email: email, password: password);
      Get.offAllNamed('/');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
