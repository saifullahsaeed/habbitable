import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/screens/progress/widgets/value_card.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:habbitable/widgets/time_spent_chart.dart';
import 'package:line_icons/line_icons.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ValueCard(
                    title: "Habits Completed",
                    value: "12",
                  ),
                  const SizedBox(width: 10),
                  ValueCard(
                    title: "Completion Rate",
                    value: "72%",
                    subtitle: -2,
                  ),
                  const SizedBox(width: 10),
                  ValueCard(
                    title: "Total Habits Active",
                    value: "3",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/calender');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LineIcons.alternateFire,
                              size: 20,
                              color: Get.theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "All Habits",
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/calender');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LineIcons.barChartAlt,
                              size: 20,
                              color: Get.theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Today",
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: controller.getTimeSpent(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return TimeSpentChart(
                      timeSpents: [0, 0, 0, 0, 0, 0, 0],
                      title: 'Time spent',
                      subtitle: 'Time spent this week on habits',
                      barColor: Get.theme.colorScheme.primary,
                      barBackgroundColor:
                          Get.theme.colorScheme.primary.withOpacity(0.2),
                      touchedBarColor: Get.theme.colorScheme.secondary,
                      barTextColor: Get.theme.colorScheme.primary,
                      dayLetterColor: Get.theme.colorScheme.primary,
                    );
                  }
                  return TimeSpentChart(
                    timeSpents: snapshot.data!,
                    title: 'Time spent',
                    subtitle: 'Time spent this week on habits',
                    barColor: Get.theme.colorScheme.primary,
                    barBackgroundColor:
                        Get.theme.colorScheme.primary.withOpacity(0.2),
                    touchedBarColor: Get.theme.colorScheme.secondary,
                    barTextColor: Get.theme.colorScheme.primary,
                    dayLetterColor: Get.theme.colorScheme.primary,
                  );
                },
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: controller.getTimeSpent(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return TimeSpentChart(
                      timeSpents: [0, 0, 0, 0, 0, 0, 0],
                      title: 'Completion Rate',
                      subtitle: 'Completion rate this week habits (%)',
                      barColor: Get.theme.colorScheme.primary.withOpacity(0.2),
                      barBackgroundColor:
                          Get.theme.colorScheme.primary.withOpacity(0.1),
                      touchedBarColor: Get.theme.colorScheme.secondary,
                      barTextColor: Get.theme.colorScheme.primary,
                      dayLetterColor: Get.theme.colorScheme.primary,
                    );
                  }
                  return TimeSpentChart(
                    timeSpents: snapshot.data!,
                    title: 'Completion Rate',
                    subtitle: 'Completion rate this week habits (%)',
                    barColor: Get.theme.colorScheme.primary,
                    barBackgroundColor:
                        Get.theme.colorScheme.primary.withOpacity(0.1),
                    touchedBarColor: Get.theme.colorScheme.secondary,
                    barTextColor: Get.theme.colorScheme.primary,
                    dayLetterColor: Get.theme.colorScheme.primary,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
