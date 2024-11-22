import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarStyle calendarStyle = CalendarStyle(
  outsideDaysVisible: false,
  todayDecoration: BoxDecoration(
    color: Get.theme.colorScheme.secondary.withOpacity(0.5),
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  selectedDecoration: BoxDecoration(
    color: Get.theme.colorScheme.primary,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  weekendDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  selectedTextStyle: Get.textTheme.bodyLarge!.copyWith(
    color: Get.theme.colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
  ),
  todayTextStyle: Get.textTheme.bodyLarge!.copyWith(
    color: Get.theme.colorScheme.onSurface,
  ),
  defaultTextStyle: Get.textTheme.bodyLarge!.copyWith(
    color: Get.theme.colorScheme.onSurface,
  ),
  weekendTextStyle: Get.textTheme.bodyLarge!.copyWith(
    color: Get.theme.colorScheme.onSurface,
  ),
  defaultDecoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

DaysOfWeekStyle daysOfWeekStyle = DaysOfWeekStyle(
  weekdayStyle: Get.textTheme.bodyMedium!.copyWith(
    color: Get.theme.colorScheme.onSurface,
    fontWeight: FontWeight.w600,
  ),
  weekendStyle: Get.textTheme.bodyMedium!.copyWith(
    color: Get.theme.colorScheme.onSurface,
    fontWeight: FontWeight.w600,
  ),
);
