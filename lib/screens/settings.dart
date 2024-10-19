import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final GlobalAuthenticationService _authenticationService =
      Get.find<GlobalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              _authenticationService.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
