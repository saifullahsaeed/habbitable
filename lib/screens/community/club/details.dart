import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/club/details.dart';
import 'package:habbitable/screens/community/club/controllers/club_details.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ClubDetailsScreen extends GetView<ClubDetailsController> {
  final String clubId;
  const ClubDetailsScreen({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClubDetails>(
      future: controller.getClub(clubId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: MainAppBar(
              showTitle: false,
              showNotifications: false,
            ),
            body: Column(
              children: [
                // Details Section
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data!.club.image?.url ?? "",
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.club.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.club.description ?? "",
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.group,
                                      size: 12,
                                      applyTextScaling: true,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Members",
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        color: Get.theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data!.totalMembers.toString(),
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.list,
                                      size: 12,
                                      applyTextScaling: true,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Habits",
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        color: Get.theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data!.habitsCount.toString(),
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 12,
                                      applyTextScaling: true,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Created At",
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        color: Get.theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  formatDate(snapshot.data!.club.createdAt),
                                  style: Get.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Habits",
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Habits List Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: snapshot.data!.habits.length,
                      itemBuilder: (context, index) {
                        return HabbitCard(
                          habit: snapshot.data!.habits[index],
                          onCompleted: (isCompleted) {},
                          disabled: true,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Loading..."),
          ),
        );
      },
    );
  }
}
