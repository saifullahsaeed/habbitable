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

TimeOfDay timeOfDayFromString(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1].split(' ')[0]);
  final period = parts[1].split(' ')[1].toUpperCase();
  final adjustedHour = period == 'PM' && hour != 12 ? hour + 12 : hour;
  return TimeOfDay(hour: adjustedHour, minute: minute);
}

TimeOfDay timeOfDayFromDateTime(DateTime date) {
  return TimeOfDay(hour: date.hour, minute: date.minute);
}

String timeOfDayToString(TimeOfDay time) {
  final String ampm = time.hour >= 12 ? 'PM' : 'AM';
  final int adjustedHour = time.hour > 12 ? time.hour - 12 : time.hour;
  return '${adjustedHour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $ampm';
}

DateTime dateTimeFromTimeOfDay(TimeOfDay time) {
  return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
      time.hour, time.minute);
}

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays == 0) {
    if (difference.inHours == 0) {
      if (difference.inMinutes == 0) {
        return 'Just now';
      }
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    }
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  }
}
