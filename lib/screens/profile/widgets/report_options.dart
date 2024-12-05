import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/setting_tile.dart';

class ReportOptions extends StatelessWidget {
  final BuildContext context;
  const ReportOptions(
      {super.key, required this.context, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingTile(
            icon: Icons.person_remove_outlined,
            title: 'Harassment or Bullying',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.warning_outlined,
            title: 'Hate Speech or Discrimination',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.block_outlined,
            title: 'Inappropriate Content',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.shopping_bag_outlined,
            title: 'Spam or Scam',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.person_outline,
            title: 'Fake Account or Impersonation',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.copyright_outlined,
            title: 'Intellectual Property Violation',
            onTap: () {
              reportUser();
            },
          ),
          const SizedBox(height: 10),
          SettingTile(
            icon: Icons.more_horiz,
            title: 'Something Else',
            onTap: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) => CustomReportDialog(
                  context: context,
                  controller: controller,
                ),
              );
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

void reportUser() {
  Get.back();
}

class CustomReportDialog extends StatelessWidget {
  final BuildContext context;
  const CustomReportDialog(
      {super.key, required this.context, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why are you reporting this user?',
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          buildInput(
            label: 'Description',
            hint: 'Provide a detailed description',
            controller: controller,
            context: context,
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButtonCustom(
                  label: 'Cancel',
                  color: Get.theme.colorScheme.error,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MainButton(
                  onPressed: () {},
                  label: 'Report',
                ),
              ),
            ],
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
