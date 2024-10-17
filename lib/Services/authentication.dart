import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';
import 'package:habbitable/utils/snackbar.dart';

class GlobalAuthenticationService extends GetxController {
  final RxBool _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  set isAuthenticated(bool value) => _isAuthenticated.update((val) => value);

  @override
  void onInit() {
    super.onInit();
    _isAuthenticated.value =
        Get.find<LocalStorageService>().getData("isAuthenticated") ?? false;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      isAuthenticated = true;
      Get.find<LocalStorageService>().setData("isAuthenticated", true);
    } catch (e) {
      showSnackBar(title: 'Error', message: e.toString(), type: 'error');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    isAuthenticated = false;
    Get.find<LocalStorageService>().setData("isAuthenticated", false);
  }
}
