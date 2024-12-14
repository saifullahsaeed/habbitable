import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/details.dart';
import 'package:habbitable/models/club/post.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/screens/community/club/widgets/club_header.dart';
import 'package:habbitable/screens/community/club/widgets/newpost_loading.dart';
import 'package:habbitable/screens/community/club/widgets/post.dart';

class ClubController extends GetxController {
  final clubsService = Get.find<ClubsService>();
  ScrollController scrollController = ScrollController();
  GlobalAuthenticationService authService =
      Get.find<GlobalAuthenticationService>();
  RxList<Widget> feed = RxList<Widget>.empty();
  FocusNode focusNode = FocusNode();
  Rx<ClubDetails?> clubDetails = Rx<ClubDetails?>(null);
  Rx<User?> user = Rx<User?>(null);
  String clubId = Get.parameters['clubId']!;
  int feedLength = 10;
  int feedOffset = 0;
  RxBool isLoading = false.obs;
  RxBool isClubLoading = false.obs;
  RxBool appBarTitleVisible = false.obs;
  RxBool moreAvailable = true.obs;
  @override
  void onInit() {
    super.onInit();
    feed.insert(0, ClubScreenHeader(controller: this));
    getClubDetails();
    getClubFeed(clubId);
    user.value = authService.currentUser;
    scrollController.addListener(() {
      appBarTitleVisible.value = scrollController.offset > 30;
      if (moreAvailable.value) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent * 0.8) {
          feedLength += 10;
          feedOffset = feedOffset + 10;
          getClubFeed(clubId);
        }
      }
    });
    clubsService.actionPulser.stream.listen((event) {
      if (event.contains('addPost')) {
        //set limi and offset to 0
        feedLength = 10;
        feedOffset = 0;
        getClubFeed(clubId);
      }
    });
  }

  Future<void> getClubFeed(String clubId) async {
    if (isLoading.value) return;
    isLoading.value = true;
    feed.insert(feed.length, const NewPostLoading());
    final List<Post> res =
        await clubsService.getClubFeed(clubId, feedLength, feedOffset);
    feed.removeAt(feed.length - 1);
    feed.addAll(res.map((e) => PostWidget(post: e)));
    moreAvailable.value = res.length == feedLength;
    isLoading.value = false;
  }

  Future<void> getClubDetails() async {
    isClubLoading.value = true;
    final res = await clubsService.getClub(clubId);
    clubDetails.value = res;
    isClubLoading.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
