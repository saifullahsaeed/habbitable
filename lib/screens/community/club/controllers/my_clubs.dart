import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/club.dart';

class MyClubsController extends GetxController {
  final ClubsService clubsService = Get.find<ClubsService>();
  final ScrollController scrollController = ScrollController();

  final clubs = <Club>[].obs;
  RxBool isLoading = false.obs;
  int limit = 20;
  int offset = 0;
  bool moreAvailable = true;

  @override
  void onInit() {
    super.onInit();
    fetchClubs();
    scrollController.addListener(() {
      if (moreAvailable) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent * 0.8) {
          limit += 10;
          offset = offset + 10;
          fetchClubs();
        }
      }
    });
  }

  Future<void> fetchClubs() async {
    if (isLoading.value) return;
    isLoading.value = true;
    final clubs = await clubsService.getMyClubs(limit: limit, offset: offset);
    this.clubs.value = clubs;
    moreAvailable = clubs.length == limit;
    isLoading.value = false;
  }
}
