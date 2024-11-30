import 'package:flutter/material.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/screens/community/widgets/sent_request.dart';
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
                return SentRequestItem(
                  request: sentRequests[index],
                  onWithdraw: () => withdrawRequest(sentRequests[index].id),
                );
              },
            ),
    );
  }
}
