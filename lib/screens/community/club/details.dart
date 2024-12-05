import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ClubDetailsScreen extends StatelessWidget {
  final String clubId;
  const ClubDetailsScreen({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showTitle: false,
        showNotifications: false,
      ),
      body: SingleChildScrollView(
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
                      "https://cdn.habbitable.com/thumb-1920-1345029.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Club Name",
                style: Get.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Club Description will be here making it long enough to see the text wrapping and going to the next line and then we will see what happens. Make it long enough to see the text wrapping and going to the next line and then we will see what happens. Make it long enough to see the text wrapping and going to the next line and then we will see what happens. Make it long enough to see the text wrapping and going to the next line and then we will see what happens.",
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
                        "100",
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
                        "10",
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
                        "12 Dec 2024",
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
