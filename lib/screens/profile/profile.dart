import 'package:flutter/material.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/models/user.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/profile/widgets/profile_options.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:habbitable/widgets/setting_tile.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  final User user;
  const ProfileScreen({super.key, required this.userId, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  late int userId;
  final TextEditingController reportController = TextEditingController();
  @override
  void initState() {
    userId = authService.currentUser.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name, style: Get.textTheme.titleMedium),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) => ProfileOptions(
                    context: context, reportController: reportController),
              );
            },
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Center(
                child: InitialsImagePlaceholder(
                  name: widget.user.name,
                  radius: 50,
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.user.name, style: Get.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
