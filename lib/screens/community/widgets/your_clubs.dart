import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/community/controllers/explore_controller.dart';
import 'package:habbitable/screens/community/widgets/club_card.dart';

class YourClubs extends StatelessWidget {
  final ExploreController controller;
  const YourClubs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Clubs",
              style: Get.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/myclubs');
              },
              child: Row(
                children: [
                  Text(
                    "See All",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    CupertinoIcons.arrow_right,
                    size: 16,
                    color: Get.theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future: controller.getMyClubs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading clubs",
                  style: Get.textTheme.bodyMedium,
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return SizedBox(
                width: Get.width,
                height: Get.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.group_solid,
                      size: 40,
                      color: Get.theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "You haven't joined any clubs yet.",
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Explore clubs to join and start your journey to a healthier lifestyle.",
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/explore/clubs/search');
                      },
                      child: Text(
                        "Search for clubs",
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClubCard(club: snapshot.data![index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
