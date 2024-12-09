import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/club/widgets/home_post.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:habbitable/screens/community/widgets/friend_request_card.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.receivedRequests.value.isNotEmpty) ...[
                  Text(
                    "Friend Requests",
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: controller.getReceivedRequests(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Obx(
                        () => CarouselSlider(
                          options: CarouselOptions(
                            height: 155,
                            viewportFraction: 0.95,
                            enableInfiniteScroll: false,
                            pageSnapping: true,
                            enlargeCenterPage: false,
                            enlargeFactor: 0.2,
                            clipBehavior: Clip.antiAlias,
                          ),
                          items: controller.receivedRequests.value
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: FriendRequestCard(
                                      request: e,
                                      onAccept: () =>
                                          controller.acceptRequest(e.id),
                                      onReject: () =>
                                          controller.rejectRequest(e.id),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/createclub');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Get.theme.colorScheme.primary
                                    .withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Add New Club",
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/createclub');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.explore_outlined,
                                color: Get.theme.colorScheme.onSurface,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Explore Clubs",
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                future: controller.getFeed(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.posts.isEmpty) {
                    return const Center(
                      child: Text("No posts found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.posts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 1,
                        ),
                        child: PostCardHome(
                          post: controller.posts[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
