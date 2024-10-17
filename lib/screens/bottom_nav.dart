import 'package:flutter/material.dart';
import 'package:habbitable/screens/progress.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:habbitable/screens/home.dart';
import 'package:habbitable/screens/settings.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const ProgressScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bar_chart),
        title: 'Progress',
        activeColorPrimary: Colors.blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: 'Settings',
        activeColorPrimary: Colors.blue,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style16,
    );
  }
}
