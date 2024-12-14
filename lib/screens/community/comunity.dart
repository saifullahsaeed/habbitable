import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ComunityScreen extends StatelessWidget {
  const ComunityScreen({super.key});
  CommunityController get controller => Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Community",
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/searchuser');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.feed.value.isEmpty) {
          return const Center(
            child: Text("No posts found"),
          );
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: controller.feed.value.length,
            shrinkWrap: true,
            controller: controller.scrollControllerHomeFeed,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 1,
                ),
                child: controller.feed.value[index],
              );
            },
          ),
        );
      }),
    );
  }
}
