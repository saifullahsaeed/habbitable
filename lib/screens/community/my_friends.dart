import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/screens/community/widgets/empty_screen.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:habbitable/widgets/loader.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class MyFriendsScreen extends StatefulWidget {
  const MyFriendsScreen({super.key});

  @override
  State<MyFriendsScreen> createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  final UserRepository userRepository = UserRepository();
  final GlobalAuthenticationService authenticationService =
      Get.find<GlobalAuthenticationService>();
  late User me;
  List<Friend> friends = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    me = authenticationService.currentUser;
    getMyFriends();
  }

  Future<void> getMyFriends() async {
    final response = await userRepository.getMyFriends(0, 10);
    if (response.statusCode == 200) {
      friends = List<Friend>.from(
          response.data.map((request) => Friend.fromJson(request)));

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeFriend(int id, int removeId) async {
    setState(() {
      friends.removeWhere((friendship) => friendship.id == removeId);
    });
    userRepository.removeFriend(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "My Friends", showNotifications: false),
      body: isLoading
          ? const LoaderAnimation()
          : friends.isEmpty
              ? const EmptySocialScreen(
                  title: "No Friends",
                  subtitle: "You have no friends yet",
                )
              : SwipeRefresh.builder(
                  stateStream: Stream.value(SwipeRefreshState.hidden),
                  itemCount: friends.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onRefresh: () async {
                    await getMyFriends();
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
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          '/profile/${Friend.otherUser(friends[index], me.id).id}',
                                          arguments: {
                                            'userId': Friend.otherUser(
                                                    friends[index], me.id)
                                                .id
                                          },
                                        );
                                      },
                                      child: Friend.otherUser(
                                                      friends[index], me.id)
                                                  .avatar !=
                                              null
                                          ? CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                Friend.otherUser(
                                                        friends[index], me.id)
                                                    .avatar!
                                                    .url,
                                              ),
                                            )
                                          : InitialsImagePlaceholder(
                                              name: Friend.otherUser(
                                                      friends[index], me.id)
                                                  .name,
                                              radius: 20,
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Friend.otherUser(
                                                    friends[index], me.id)
                                                .name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Friend since ${timeAgo(friends[index].createdAt)}",
                                            style: Get.textTheme.bodySmall!
                                                .copyWith(
                                              color:
                                                  Get.theme.colorScheme.outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          showDragHandle: true,
                                          builder: (context) => FriendMenuSheet(
                                            friend: friends[index],
                                            removeFriend: removeFriend,
                                            me: me,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
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

class FriendMenuSheet extends StatelessWidget {
  const FriendMenuSheet(
      {super.key,
      required this.friend,
      required this.removeFriend,
      required this.me});
  final Friend friend;
  final Function(int, int) removeFriend;
  final User me;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Remove Friend"),
            onTap: () {
              removeFriend(Friend.otherUser(friend, me.id).id, friend.id);
              Get.back();
            },
            tileColor: Get.theme.colorScheme.error.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
