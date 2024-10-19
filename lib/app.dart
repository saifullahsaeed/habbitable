import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/router.dart';
import 'package:habbitable/style/theme.dart';
import 'package:habbitable/utils/consts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultGlobalState: true,
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
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
