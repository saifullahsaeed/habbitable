import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/post.dart';
import 'package:habbitable/models/friend.dart';
import 'package:habbitable/repos/user.dart';
import 'package:habbitable/screens/community/club/widgets/home_post.dart';
import 'package:habbitable/screens/community/club/widgets/newpost_loading.dart';
import 'package:habbitable/screens/community/widgets/friend_requests_slider.dart';
import 'package:habbitable/screens/community/widgets/home_action_buttons.dart';

class CommunityController extends GetxController {
  UserRepository userRepository = UserRepository();
  final clubsService = Get.find<ClubsService>();
  ScrollController scrollControllerHomeFeed = ScrollController();

  //actions queue
  List<FriendRequest> queueInAction = [];
  //feed
  Rx<List<Widget>> feed = Rx<List<Widget>>([]);
  //pagination
  int feedLength = 10;
  int feedOffset = 0;
  //loading
  RxBool moreAvailable = false.obs;
  RxBool moreLoading = false.obs;
  //dataLists

  RxList<Post> posts = RxList<Post>.empty();

  @override
  void onInit() {
    super.onInit();
    feed.value.insert(0, HomeActionButtons());
    feed.value.insert(1, FriendRequestsSlider(controller: this));
    getFeed();
    scrollControllerHomeFeed.addListener(() {
      if (moreAvailable.value) {
        if (scrollControllerHomeFeed.offset >=
            scrollControllerHomeFeed.position.maxScrollExtent * 0.8) {
          feedLength += 10;
          feedOffset = feedOffset + 10;
          getFeed();
        }
      }
    });
  }

  Future<void> getFeed() async {
    if (moreLoading.value) return;
    moreLoading.value = true;
    feed.value.insert(feed.value.length, const NewPostLoading());
    List<Post> postsResponse =
        await clubsService.getFeed(feedLength, feedOffset);
    if (postsResponse.isNotEmpty) {
      feed.value.removeAt(feed.value.length - 1);
      feed.value = [
        ...feed.value,
        ...postsResponse.map((post) => PostCardHome(post: post))
      ];
    }
    moreAvailable.value = postsResponse.length == feedLength;

    moreLoading.value = false;
  }

  Future<void> likePost(int clubId, int postId) async {
    bool isLiked = posts.firstWhere((post) => post.id == postId).isLiked;
    posts.firstWhere((post) => post.id == postId).isLiked = !isLiked;
    clubsService.likePost(clubId.toString(), postId.toString()).then((value) {
      if (value) {
        posts.firstWhere((post) => post.id == postId).isLiked = !isLiked;
      }
    });
  }

  Future<List<FriendRequest>> getReceivedRequests() async {
    try {
      final response = await userRepository.getReceivedRequests(0, 10);
      if (response.statusCode == 200) {
        return List<FriendRequest>.from(
            response.data.map((request) => FriendRequest.fromJson(request)));
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  Future<void> acceptRequest(int requestId) async {
    userRepository.acceptRequest(requestId);
  }

  Future<void> rejectRequest(int requestId) async {
    userRepository.rejectRequest(requestId);
  }
}
