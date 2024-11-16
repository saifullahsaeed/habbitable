import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:habbitable/widgets/setting_tile.dart';
import 'package:line_icons/line_icons.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: 'Social',
        showNotifications: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SettingTile(
              icon: Icons.person_add_alt_1_outlined,
              title: 'Sent Requests',
              onTap: () {
                Get.toNamed('/sentrequests');
              },
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: LineIcons.userPlus,
              title: 'Received Requests',
              onTap: () {
                Get.toNamed('/receivedrequests');
              },
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: Icons.person_add_alt_1_outlined,
              title: 'Friends',
              onTap: () {
                Get.toNamed('/myfriends');
              },
            ),
          ],
        ),
      ),
    );
  }
}
