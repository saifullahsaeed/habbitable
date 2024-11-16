import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:habbitable/widgets/loader.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class SentRequestsScreen extends StatefulWidget {
  const SentRequestsScreen({super.key});

  @override
  State<SentRequestsScreen> createState() => _SentRequestsScreenState();
}

class _SentRequestsScreenState extends State<SentRequestsScreen> {
  final UserRepository userRepository = UserRepository();
  List<FriendRequest> sentRequests = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getSentRequests();
  }

  Future<void> getSentRequests() async {
    final response = await userRepository.getSentRequests(0, 10);
    if (response.statusCode == 200) {
      sentRequests = List<FriendRequest>.from(
          response.data.map((request) => FriendRequest.fromJson(request)));
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> withdrawRequest(int id) async {
    userRepository.withdrawRequest(id);

    setState(() {
      sentRequests.removeWhere((request) => request.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Sent Requests", showNotifications: false),
      body: isLoading
          ? const LoaderAnimation()
          : SwipeRefresh.builder(
              stateStream: Stream.value(SwipeRefreshState.hidden),
              itemCount: sentRequests.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              onRefresh: () async {
                await getSentRequests();
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
                                  name: sentRequests[index].addressee.name,
                                  radius: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    sentRequests[index].addressee.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            timeAgo(sentRequests[index].createdAt),
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Waiting for approval.",
                        style: Get.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButtonCustom(
                              onPressed: () =>
                                  withdrawRequest(sentRequests[index].id),
                              color: Get.theme.colorScheme.error,
                              label: "Withdraw Request",
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
