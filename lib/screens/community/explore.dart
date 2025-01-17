import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/controllers/explore_controller.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ExploreScreen extends GetView<ExploreController> {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Explore",
        showNotifications: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.exploreFeed.length,
        controller: controller.recommendedClubsController,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: controller.exploreFeed[index],
          );
        },
      ),
    );
  }
}
