import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/models/user.dart';

class AuthController extends GetxController {
  final GlobalAuthenticationService _auth =
      Get.find<GlobalAuthenticationService>();

  Future<void> login(String email, String password) async {
    try {
      await _auth.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(
      String name, String email, String username, String password) async {
    try {
      SignupModel signupModel = SignupModel(
          name: name, email: email, username: username, password: password);
      bool success = await _auth.signup(signupModel);
      if (success) {
        Get.offAllNamed('/auth/login');
      }
    } catch (e) {
      rethrow;
    }
  }
}
