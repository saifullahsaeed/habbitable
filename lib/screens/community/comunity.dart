import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:habbitable/screens/community/widgets/friend_request_card.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Friend Requests",
                style: Get.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.receivedRequests.value.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    height: 165,
                    viewportFraction: 0.95,
                    enableInfiniteScroll: false,
                    pageSnapping: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    clipBehavior: Clip.antiAlias,
                  ),
                  items: controller.receivedRequests.value
                      .map((e) => FriendRequestCard(
                            request: e,
                            onAccept: () => controller.acceptRequest(e.id),
                            onReject: () => controller.rejectRequest(e.id),
                          ))
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
