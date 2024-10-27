import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/Services/theme.dart';
import 'package:habbitable/router.dart';
import 'package:habbitable/style/theme.dart';
import 'package:habbitable/utils/consts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
    ThemeService themeService = Get.put(
      ThemeService(),
      permanent: true,
    );
    return GetMaterialApp(
      key: key,
      debugShowCheckedModeBanner: false,
      defaultGlobalState: true,
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeService.theme == 0
          ? ThemeMode.system
          : themeService.theme == 1
              ? ThemeMode.light
              : ThemeMode.dark,
      getPages: routes,
      onInit: () {
        Get.put(
          GlobalAuthenticationService(),
          permanent: true,
        );
        Get.put(
          HabitsService(),
          permanent: true,
        );
      },
    );
  }
}
