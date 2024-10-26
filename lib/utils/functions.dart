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

IconData iconDataFromString(int icon, String fontFamily) {
  return IconData(icon, fontFamily: fontFamily);
}

String monthFromNumber(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

String formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')} ${monthFromNumber(date.month)} ${date.year}';
}
