import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/screens/habit/controllers/controller.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/history.dart';

class HabitScreen extends GetView<HabitScreenController> {
  final Habit habit;
  const HabitScreen({super.key, required this.habit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${habit.streak} days",
          style: Get.theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.name,
              style: Get.theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              habit.description ?? "",
              style: Get.theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            if (!habit.isCompleted())
              InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () {},
                onLongPress: () {
                  // Assuming there's a function to complete the habit
                  // This is a placeholder for the actual function call
                  // completeHabit(habit.id);
                },
                splashColor: Get.theme.colorScheme.primary,
                splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                child: Container(
                  width: Get.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Complete",
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            if (habit.isCompleted())
              Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Get.theme.colorScheme.primary,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Completed Today",
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: habit.color.withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Time",
                          style: Get.theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${habit.time} min",
                          style: Get.theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: habit.color.withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Frequency",
                          style: Get.theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          habit.frequency,
                          style: Get.theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: habit.color.withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Goal",
                          style: Get.theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${habit.goal.toString()} days",
                          style: Get.theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Next Due",
              style: Get.theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  "${formatDate(habit.nextDue)} at ${timeFromDate(habit.nextDue)}",
                  style: Get.theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "History",
              style: Get.theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => controller.habitLogsLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : HistoryWidget(
                      habitLogs: controller.habitLogs,
                      baseColor: habit.color,
                      selectedMonthChanged: (DateTime month) {
                        controller.fetchHabitLogs(habit.id, month);
                      },
                      onDaySelected: (List<HabitLog> logs) {
                        controller.onDaySelected(logs);
                      },
                    ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => controller.selectedDayLogs.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: controller.selectedDayLogs.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Get.theme.cardColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  timeFromDate(
                                      controller.selectedDayLogs[index].date!),
                                  style: Get.theme.textTheme.bodySmall,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    if (controller.selectedDayLogs[index].action
                                            .toLowerCase() ==
                                        "complete")
                                      const Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: Colors.green,
                                      ),
                                    if (controller.selectedDayLogs[index].action
                                            .toLowerCase() ==
                                        "reversed")
                                      const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "Marked as ${controller.selectedDayLogs[index].action.toLowerCase()}",
                                      style: Get.theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: Get.height * 0.2,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.grey,
                            size: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "No activity for this day",
                            style: Get.theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
