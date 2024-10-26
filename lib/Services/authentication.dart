import 'dart:convert';

import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';
import 'package:habbitable/Services/sqlite.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/repos/auth.dart';
import 'package:habbitable/utils/snackbar.dart';

class GlobalAuthenticationService extends GetxController {
  bool get isAuthenticated =>
      Get.find<LocalStorageService>().getData("token") != null;
  int get userId =>
      Get.find<LocalStorageService>().getData("user")['id'] as int;
  LocalStorageService localStorageService = Get.find<LocalStorageService>();
  SqliteService sqliteService = Get.find<SqliteService>();
  AuthRepository authRepository = AuthRepository();
  Future<bool> signup(SignupModel signupModel) async {
    try {
      await authRepository.register(signupModel);
      showSnackBar(
          title: 'Success', message: 'Signup successful', type: 'success');
      return true;
    } catch (e) {
      showSnackBar(title: 'Error', message: e.toString(), type: 'error');
      return false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository
          .login(LoginModel(email: email, password: password));
      localStorageService.setData("token", response.data['access_token']);
      localStorageService.setData("user", response.data['user']);
      Get.offAllNamed('/');
    } catch (e) {
      showSnackBar(title: 'Error', message: e.toString(), type: 'error');
    }
  }

  Future<User> currentUser() async {
    final userData = localStorageService.getData("user") as String;
    return User.fromJson(jsonDecode(userData));
  }

  Future<void> logout() async {
    localStorageService.clearData();
    Get.offAllNamed('/auth');
  }
}
