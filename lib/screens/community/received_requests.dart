import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/screens/community/widgets/empty_screen.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:habbitable/widgets/loader.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class ReceivedRequestsScreen extends StatefulWidget {
  const ReceivedRequestsScreen({super.key});

  @override
  State<ReceivedRequestsScreen> createState() => _ReceivedRequestsScreenState();
}

class _ReceivedRequestsScreenState extends State<ReceivedRequestsScreen> {
  final UserRepository userRepository = UserRepository();
  List<FriendRequest> receivedRequests = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getReceivedRequests();
  }

  Future<void> getReceivedRequests() async {
    final response = await userRepository.getReceivedRequests(0, 10);
    if (response.statusCode == 200) {
      receivedRequests = List<FriendRequest>.from(
          response.data.map((request) => FriendRequest.fromJson(request)));
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> rejectRequest(int id) async {
    userRepository.withdrawRequest(id);

    setState(() {
      receivedRequests.removeWhere((request) => request.id == id);
    });
  }

  Future<void> acceptRequest(int id) async {
    userRepository.acceptRequest(id);

    setState(() {
      receivedRequests.removeWhere((request) => request.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Received Requests", showNotifications: false),
      body: isLoading
          ? const LoaderAnimation()
          : receivedRequests.isEmpty
              ? const EmptySocialScreen(
                  title: "No Requests",
                  subtitle: "You have no received requests",
                )
              : SwipeRefresh.builder(
                  stateStream: Stream.value(SwipeRefreshState.hidden),
                  itemCount: receivedRequests.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onRefresh: () async {
                    await getReceivedRequests();
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Get.theme.cardColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    InitialsImagePlaceholder(
                                      name: receivedRequests[index]
                                          .addressee
                                          .name,
                                      radius: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        receivedRequests[index].addressee.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                timeAgo(receivedRequests[index].createdAt),
                                style: Get.textTheme.bodySmall!.copyWith(
                                  color: Get.theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Sent you a friend request.",
                            style: Get.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButtonCustom(
                                  onPressed: () =>
                                      rejectRequest(receivedRequests[index].id),
                                  color: Get.theme.colorScheme.error,
                                  label: "Reject Request",
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MainButton(
                                  onPressed: () =>
                                      acceptRequest(receivedRequests[index].id),
                                  label: "Accept Request",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
