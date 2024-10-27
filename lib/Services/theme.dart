import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';

class ThemeService extends GetxService {
  final _localStorage = Get.find<LocalStorageService>();
  final _theme =
      0.obs; //0 for default system theme, 1 for light theme, 2 for dark theme

  int get theme => _theme.value;

  void setTheme(int theme) {
    _localStorage.setData('theme', theme);
    _theme.value = theme;
  }

  @override
  void onInit() {
    super.onInit();
    final themeData = _localStorage.getData('theme');
    if (themeData != null) {
      _theme.value = themeData;
    } else {
      _theme.value = Get.isPlatformDarkMode ? 2 : 1;
    }
  }
}
