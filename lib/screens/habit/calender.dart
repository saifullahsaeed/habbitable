import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/habits.dart';
import 'package:habbitable/style/calender.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:habbitable/widgets/mainappbar.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitCalenderScreen extends GetView<HabitsService> {
  const HabitCalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: MainAppBar(
          title: formatedDateForCalender(controller.selectedDay.value),
          showNotifications: false,
          actions: [
            Tooltip(
              message: 'Reset to today',
              child: IconButton(
                onPressed: () {
                  controller.onDaySelected(DateTime.now(), DateTime.now());
                },
                icon: const Icon(Icons.refresh),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2040, 3, 14),
                formatAnimationCurve: Curves.easeInOut,
                pageAnimationCurve: Curves.easeInCirc,
                calendarFormat: CalendarFormat.week,
                availableGestures: AvailableGestures.all,
                calendarStyle: calendarStyle,
                focusedDay: controller.focusedDay.value,
                headerVisible: false,
                daysOfWeekHeight: 20,
                daysOfWeekStyle: daysOfWeekStyle,
                rowHeight: 60,
                selectedDayPredicate: (day) {
                  return isSameDayAs(controller.selectedDay.value, day);
                },
                onDaySelected: controller.onDaySelected,
              ),
              if (controller.isLoading.value)
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => HabitCardShimmer()),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.habitsOnDate.length,
                    itemBuilder: (context, index) => HabbitCard(
                      habit: controller.habitsOnDate[index],
                      onCompleted: (completed) {},
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
