import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/screens/community/controllers/comunity_controller.dart';
import 'package:habbitable/screens/community/widgets/empty_screen.dart';
import 'package:habbitable/widgets/loader.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:habbitable/screens/community/widgets/friend_request_card.dart';

class ReceivedRequestsScreen extends StatefulWidget {
  const ReceivedRequestsScreen({super.key});

  @override
  State<ReceivedRequestsScreen> createState() => _ReceivedRequestsScreenState();
}

class _ReceivedRequestsScreenState extends State<ReceivedRequestsScreen> {
  final UserRepository userRepository = UserRepository();
  List<FriendRequest> receivedRequests = [];
  CommunityController controller = Get.find<CommunityController>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller.getReceivedRequests();
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
      body: FutureBuilder<void>(
        future: controller.getReceivedRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderAnimation();
          }
          if (snapshot.hasError) {
            return const EmptySocialScreen(
              title: "Error",
              subtitle: "Failed to load requests",
            );
          }

          return Obx(() {
            if (controller.receivedRequestsList.isEmpty) {
              return const EmptySocialScreen(
                title: "No Requests",
                subtitle: "You have no received requests",
              );
            }

            return SwipeRefresh.builder(
              stateStream: Stream.value(SwipeRefreshState.hidden),
              itemCount: controller.receivedRequestsList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              onRefresh: () async {
                controller.getReceivedRequests();
              },
              itemBuilder: (context, index) {
                return FriendRequestCard(
                  request: controller.receivedRequestsList[index],
                  onAccept: () =>
                      acceptRequest(controller.receivedRequestsList[index].id),
                  onReject: () =>
                      rejectRequest(controller.receivedRequestsList[index].id),
                );
              },
            );
          });
        },
      ),
    );
  }
}
