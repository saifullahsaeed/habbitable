import 'package:flutter/material.dart';

String dayFromDate(DateTime date) {
  if (date.weekday == DateTime.now().weekday) {
    return "Today";
  }
  switch (date.weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "";
  }
}

String timeFromDate(DateTime date) {
  String ampm = date.hour >= 12 ? "PM" : "AM";
  int adjustedHour = date.hour % 12 == 0 ? 12 : date.hour % 12;
  return "${adjustedHour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $ampm";
}

IconData iconDataFromString(String icon) {
  return IconData(int.parse(icon), fontFamily: 'MaterialIcons');
}
