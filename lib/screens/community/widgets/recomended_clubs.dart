import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/controllers/explore_controller.dart';
import 'package:habbitable/screens/community/widgets/club_card_h.dart';

class RecomendedClubs extends StatelessWidget {
  final ExploreController exploreController;
  const RecomendedClubs({super.key, required this.exploreController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recomended Clubs",
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: ListView.builder(
                itemCount: exploreController.categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(exploreController.categories[index].name),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        selectedColor: Get.theme.colorScheme.primary,
                        selected: exploreController.selectedCategoryId.value ==
                            exploreController.categories[index].id,
                        onSelected: (value) {
                          exploreController.updateSelectedCategory(
                              exploreController.categories[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (exploreController.isLoading.value)
            const Center(
              child: CupertinoActivityIndicator(),
            ),
          if (exploreController.recommendedClubs.isNotEmpty)
            ListView.builder(
              itemCount: exploreController.recommendedClubs.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ClubCardHorizontal(
                    club: exploreController.recommendedClubs[index]);
              },
            ),
        ],
      ),
    );
  }
}
