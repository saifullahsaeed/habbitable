import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/models/image.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/screens/community/club/widgets/club_tile.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClubTile(
                club: Club(
                  id: 1,
                  name: "Healthy Hacklers Club💪",
                  description:
                      "A club for healthy hacklers who want to stay healthy and fit. We will help you to stay healthy and fit.",
                  imageId: 1,
                  slug: "healthy-hacklers-club",
                  isPrivate: true,
                  isVerified: true,
                  isActive: true,
                  isArchived: false,
                  ownerId: 1,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  owner: User(
                    id: 1,
                    name: "John Doe",
                    email: "john.doe@example.com",
                  ),
                  image: ImageModel(
                    id: 1,
                    userId: 1,
                    url: "https://cdn.habbitable.com/thumb-1920-1345029.png",
                    mimeType: "image/png",
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ClubTile(
                club: Club(
                  id: 2,
                  name: "Mental Health Club 🧠",
                  description:
                      "A club for mental health enthusiasts who want to stay healthy and fit. We will help you to stay healthy and fit.",
                  imageId: 1,
                  slug: "mental-health-club",
                  isPrivate: true,
                  isVerified: true,
                  isActive: true,
                  isArchived: false,
                  ownerId: 1,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  owner: User(
                    id: 1,
                    name: "John Doe",
                    email: "john.doe@example.com",
                  ),
                  image: ImageModel(
                    id: 1,
                    userId: 1,
                    url:
                        "https://cdn.habbitable.com/mental-health-blooming-human-brain-line-icon-mind-concept-love-life-new-page-illustration-free-vector.jpg",
                    mimeType: "image/png",
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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

                  return Obx(() => CarouselSlider(
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
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
