import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/comunity.dart';
import 'package:habbitable/screens/progress/progress.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:habbitable/screens/home.dart';
import 'package:habbitable/screens/settings.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      const ComunityScreen(),
      ProgressScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Get.theme.colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people),
        title: 'Comunity',
        activeColorPrimary: Get.theme.colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bar_chart),
        title: 'Progress',
        activeColorPrimary: Get.theme.colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: 'Settings',
        activeColorPrimary: Get.theme.colorScheme.primary,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style9,
      backgroundColor: Get.theme.colorScheme.surface,
      onWillPop: (value) async {
        return false;
      },
    );
  }
}
