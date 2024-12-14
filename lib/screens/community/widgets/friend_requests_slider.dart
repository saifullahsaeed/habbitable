import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:habbitable/screens/community/widgets/friend_request_card.dart';

class FriendRequestsSlider extends StatefulWidget {
  final CommunityController controller;
  const FriendRequestsSlider({super.key, required this.controller});

  @override
  State<FriendRequestsSlider> createState() => _FriendRequestsSliderState();
}

class _FriendRequestsSliderState extends State<FriendRequestsSlider> {
  List<FriendRequest> requests = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    widget.controller.getReceivedRequests().then((value) {
      setState(() {
        requests = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : requests.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Text(
                    "Friend Requests",
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: widget.controller.getReceivedRequests(),
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
                          items: requests
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: FriendRequestCard(
                                      request: e,
                                      onAccept: () =>
                                          widget.controller.acceptRequest(e.id),
                                      onReject: () =>
                                          widget.controller.rejectRequest(e.id),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              );
  }
}
