import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/clubs.dart';
import 'package:habbitable/models/club/catagory.dart';
import 'package:habbitable/models/club/club.dart';
import 'package:habbitable/screens/community/widgets/recomended_clubs.dart';
import 'package:habbitable/screens/community/widgets/your_clubs.dart';

class ExploreController extends GetxController {
  final ClubsService clubsService = Get.find<ClubsService>();
  Rx<int?> selectedCategoryId = Rx<int?>(null);
  RxList<Club> recommendedClubs = RxList.empty();
  ScrollController recommendedClubsController = ScrollController();
  RxList<Catagory> categories = RxList.empty();
  //feed
  RxList<Widget> exploreFeed = RxList<Widget>.empty();
  //limit
  int limit = 10;
  //offset
  int offset = 0;
  RxBool isLoading = false.obs;
  RxBool moreAvailable = true.obs;

  @override
  void onInit() {
    getCatagories();
    exploreFeed.add(YourClubs(controller: this));
    exploreFeed.add(RecomendedClubs(exploreController: this));
    getRecommendedClubs();
    super.onInit();
    recommendedClubsController.addListener(() {
      if (moreAvailable.value) {
        if (recommendedClubsController.offset >=
            recommendedClubsController.position.maxScrollExtent * 0.8) {
          limit += 10;
          offset = offset + 10;
          getRecommendedClubs();
        }
      }
    });
  }

  Future<List<Club>> getMyClubs() async {
    final List<Club> clubs = await clubsService.getMyClubs(
      limit: 5,
      offset: 0,
    );
    return clubs.reversed.toList();
  }

  Future<void> getCatagories() async {
    final List<Catagory> catagories = await clubsService.getCatagories();
    categories.value = catagories.toList();
  }

  void updateSelectedCategory(Catagory category) {
    if (selectedCategoryId.value == category.id) {
      selectedCategoryId.value = null;
      recommendedClubs.clear();
      moreAvailable.value = true;
      offset = 0;
      limit = 10;
      getRecommendedClubs();
    } else {
      selectedCategoryId.value = category.id;
      recommendedClubs.clear();
      moreAvailable.value = true;
      offset = 0;
      limit = 10;
      getRecommendedClubs();
    }
  }

  Future<void> getRecommendedClubs() async {
    if (isLoading.value) return;
    isLoading.value = true;
    Catagory? category =
        categories.firstWhereOrNull((c) => c.id == selectedCategoryId.value);

    final List<Club> clubs = await clubsService.getRecommendedClubs(
      category?.name,
      limit,
      offset,
    );
    recommendedClubs.addAll(clubs);
    moreAvailable.value = clubs.length == limit;
    isLoading.value = false;
  }
}
