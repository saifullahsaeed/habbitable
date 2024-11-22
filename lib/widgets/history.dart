import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit_logs.dart';
import 'package:habbitable/utils/functions.dart';

class HistoryWidget extends StatefulWidget {
  final List<HabitLog> habitLogs;
  final Color baseColor;
  final Function(DateTime) selectedMonthChanged;
  final Function(List<HabitLog>) onDaySelected;
  const HistoryWidget({
    super.key,
    required this.habitLogs,
    required this.selectedMonthChanged,
    required this.baseColor,
    required this.onDaySelected,
  });

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final List<String> months =
      List.generate(12, (index) => (index + 1).toString());
  String selectedMonth = DateTime.now().month.toString();
  String selectedYear = DateTime.now().year.toString();
  DateTime selectedDate = DateTime.now();

  void _handleMonthChange(int change) {
    setState(() {
      DateTime currentDate =
          DateTime(int.parse(selectedYear), int.parse(selectedMonth), 1);

      DateTime newDate =
          DateTime(currentDate.year, currentDate.month + change, 1);

      selectedMonth = newDate.month.toString();
      selectedYear = newDate.year.toString();

      int daysInNewMonth = DateTime(newDate.year, newDate.month + 1, 0).day;
      int targetDay = min(selectedDate.day, daysInNewMonth);
      selectedDate = DateTime(newDate.year, newDate.month, targetDay);
    });

    widget.selectedMonthChanged(
      DateTime(int.parse(selectedYear), int.parse(selectedMonth), 1),
    );
  }

  Color _getTileColor(List<HabitLog> dayLogs) {
    if (dayLogs.isEmpty) return Colors.grey.shade400;

    int completeCount =
        dayLogs.where((log) => log.action == 'completed').length;
    int reverseCount = dayLogs.where((log) => log.action == 'reverse').length;

    if (reverseCount > 0) return Colors.red;
    if (completeCount > 0) {
      return widget.baseColor.withAlpha(completeCount > 1 ? 255 : 200);
    }
    return Colors.grey.shade400;
  }

  String _getTooltipText(List<HabitLog> dayLogs) {
    if (dayLogs.isEmpty) return '';

    int completeCount =
        dayLogs.where((log) => log.action == 'completed').length;
    int reverseCount = dayLogs.where((log) => log.action == 'reverse').length;

    if (reverseCount > 0) return 'Reversed a habit';
    if (completeCount > 0) {
      return completeCount > 1
          ? "$completeCount habits completed"
          : "1 habit completed";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMonthSelector(),
          const SizedBox(height: 10),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => _handleMonthChange(-1),
          splashRadius: 20,
          visualDensity: VisualDensity.comfortable,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back_ios, size: 16),
        ),
        Text(
          '${monthFromNumber(int.parse(selectedMonth))} $selectedYear',
          style: Get.theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => _handleMonthChange(1),
          splashRadius: 20,
          visualDensity: VisualDensity.comfortable,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    int daysInMonth =
        DateTime(int.parse(selectedYear), int.parse(selectedMonth) + 1, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 20,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final date = DateTime(
          int.parse(selectedYear),
          int.parse(selectedMonth),
          index + 1,
        );
        List<HabitLog> dayLogs = widget.habitLogs
            .where((log) => isSameDay(log.date!, date))
            .toList();

        Color tileColor = _getTileColor(dayLogs);
        String tooltipText = _getTooltipText(dayLogs);

        return _buildCalendarTile(date, dayLogs, tileColor, tooltipText, index);
      },
    );
  }

  Widget _buildCalendarTile(DateTime date, List<HabitLog> dayLogs,
      Color tileColor, String tooltipText, int index) {
    bool isSelected = isSameDay(date, selectedDate);

    return Tooltip(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(2),
      ),
      preferBelow: false,
      triggerMode: TooltipTriggerMode.longPress,
      richMessage: TextSpan(
        children: [
          TextSpan(
            text: formatDate(date),
            style: Get.theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: '\n'),
          TextSpan(
            text: tooltipText,
            style: Get.theme.textTheme.bodySmall,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDate = date;
          });
          widget.onDaySelected(dayLogs);
        },
        child: Container(
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: isSelected ? Get.theme.primaryColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
