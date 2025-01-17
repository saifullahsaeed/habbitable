import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/controllers/my_clubs.dart';
import 'package:habbitable/screens/community/club/widgets/club_tile.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class MyClubsScreen extends GetView<MyClubsController> {
  const MyClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "My Clubs",
        showNotifications: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return ListView.builder(
          itemCount: controller.clubs.length,
          controller: controller.scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ClubTile(club: controller.clubs[index]),
            );
          },
        );
      }),
    );
  }
}
