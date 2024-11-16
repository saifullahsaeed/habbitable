import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:habbitable/widgets/setting_tile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final GlobalAuthenticationService _authenticationService =
      Get.find<GlobalAuthenticationService>();
  @override
  Widget build(BuildContext context) {
    User user = _authenticationService.currentUser;
    return Scaffold(
      appBar: const MainAppBar(
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/profile/${user.id}',
                          arguments: {'userId': user.id});
                    },
                    child: Row(
                      children: [
                        InitialsImagePlaceholder(
                          name: user.name,
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Get.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: Get.textTheme.bodySmall?.copyWith(
                                color: Get.theme.colorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/editprofile', arguments: {'user': user});
                    },
                    child: Row(
                      children: [
                        Text(
                          'Edit Profile',
                          style: Get.textTheme.bodySmall?.copyWith(
                            color: Get.theme.primaryColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Get.theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: Icons.tune_outlined,
              title: 'Preferences',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: CupertinoIcons.star,
              title: 'Achievements',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: LineIcons.userPlus,
              title: 'Social',
              onTap: () {
                Get.toNamed('/settings/social');
              },
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: Icons.notifications_none_outlined,
              title: 'Notifications',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            SettingTile(
              icon: Icons.share_outlined,
              title: 'Share',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.privacy_tip_outlined,
                    size: 16,
                    color: Get.theme.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text('Privacy Policy'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.link_outlined,
                    size: 16,
                    color: Get.theme.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text('Terms of Service'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _authenticationService.logout();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: 16,
                    color: Get.theme.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text('Logout'),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Version ${snapshot.data?.version}',
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: Get.theme.hintColor,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
