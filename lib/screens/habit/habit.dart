import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/screens/habit/controllers/controller.dart';
import 'package:habbitable/screens/habit/widgets/deletehabit.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/history.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:slider_button/slider_button.dart';

class HabitScreen extends GetView<HabitScreenController> {
  final Habit habit;
  HabitScreen({super.key, required this.habit});
  final HomeController homeController = Get.find<HomeController>();
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
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/habit/users', arguments: {'habit': habit});
            },
            icon: Icon(
              Icons.group_outlined,
              weight: 200,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          DeleteHabit(
            habit: habit,
            homeController: homeController,
            controller: controller,
          ),
        ],
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
              SliderButton(
                action: () async {
                  return true;
                },
                width: Get.width,
                shimmer: true,
                disable: habit.isCompleted(),
                label: Text(
                  habit.isCompleted() ? "Completed" : "Mark as completed",
                  style: Get.theme.textTheme.bodyMedium,
                ),
                buttonColor: habit.color,
                buttonSize: 50,
                buttonWidth: 150,
                icon: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: habit.color,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: habit.color,
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
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: habit.color,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.repeat_outlined,
                          color: habit.color,
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
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: habit.color,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: habit.color,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          habit.goal == 0 ? "No Goal" : "${habit.goal} times",
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Get.theme.cardColor,
                                ),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    controller.selectedDayLogs[index].user
                                                ?.avatar !=
                                            null
                                        ? CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              controller.selectedDayLogs[index]
                                                  .user!.avatar!.url,
                                            ),
                                          )
                                        : InitialsImagePlaceholder(
                                            name: controller
                                                    .selectedDayLogs[index]
                                                    .user
                                                    ?.name ??
                                                "",
                                          ),
                                    const SizedBox(width: 5),
                                    Text(
                                      controller.selectedDayLogs[index].user
                                              ?.name ??
                                          "Invalid Name",
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: Get.theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ": Marked habit as ${controller.selectedDayLogs[index].action.toLowerCase()}",
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                        color: Get.theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
