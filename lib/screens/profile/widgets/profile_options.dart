import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/profile/widgets/report_options.dart';
import 'package:habbitable/widgets/setting_tile.dart';

class ProfileOptions extends StatelessWidget {
  final BuildContext context;
  final TextEditingController reportController;
  const ProfileOptions(
      {super.key, required this.context, required this.reportController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      child: Column(
        children: [
          SettingTile(
            icon: Icons.share_outlined,
            title: 'Share Profile',
            onTap: () {
              Get.back();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.report_outlined,
            title: 'Report User',
            onTap: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) => ReportOptions(
                    context: context, controller: reportController),
              );
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.block_outlined,
            title: 'Block User',
            onTap: () {
              Get.back();
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: Get.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
