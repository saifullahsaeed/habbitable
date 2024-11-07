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
      localStorageService.setData(
          "refresh_token", response.data['refresh_token']);
      localStorageService.setData("user", response.data['user']);
      Get.offAllNamed('/');
    } catch (e) {
      showSnackBar(title: 'Error', message: e.toString(), type: 'error');
    }
  }

  Future<int> refreshToken() async {
    try {
      final response = await authRepository
          .refreshToken(localStorageService.getData("refresh_token"));
      localStorageService.setData("token", response.data['access_token']);
      localStorageService.setData(
          "refresh_token", response.data['refresh_token']);
      return 1;
    } catch (e) {
      return 0;
    }
  }

  User get currentUser {
    final userData = localStorageService.getData("user") as String;
    return User.fromJson(jsonDecode(userData));
  }

  void logout() {
    authRepository.logout();
    localStorageService.clearData();
    Get.offAllNamed('/auth');
  }
}
