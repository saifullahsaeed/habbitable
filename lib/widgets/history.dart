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
  int selectedDay = DateTime.now().day;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (selectedMonth == '1') {
                    setState(() {
                      selectedMonth = '12';
                    });
                  } else {
                    setState(() {
                      selectedMonth = (int.parse(selectedMonth) - 1).toString();
                    });
                  }
                  widget.selectedMonthChanged(DateTime(
                      int.parse(selectedYear), int.parse(selectedMonth), 1));
                },
                splashRadius: 20,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ),
              ),
              Text(
                '${monthFromNumber(int.parse(selectedMonth))} $selectedYear',
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (selectedMonth == '12') {
                    setState(() {
                      selectedMonth = '1';
                    });
                  } else {
                    setState(() {
                      selectedMonth = (int.parse(selectedMonth) + 1).toString();
                    });
                  }
                  widget.selectedMonthChanged(DateTime(
                      int.parse(selectedYear), int.parse(selectedMonth), 1));
                },
                splashRadius: 20,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 20,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              final date = DateTime(
                  int.parse(selectedYear), int.parse(selectedMonth), index + 1);
              List<HabitLog> dayLogs = widget.habitLogs
                  .where(
                    (log) => isSameDay(log.date!, date),
                  )
                  .toList();

              Color tileColor = Colors.grey.shade400;
              String tooltipText = '';

              if (dayLogs.isNotEmpty) {
                int completeCount =
                    dayLogs.where((log) => log.action == 'complete').length;
                int reverseCount =
                    dayLogs.where((log) => log.action == 'reverse').length;

                if (reverseCount > 0) {
                  tileColor = Colors.red;
                  tooltipText = 'Reversed a habit';
                } else if (completeCount > 0) {
                  tileColor = widget.baseColor;
                  if (completeCount > 1) {
                    tileColor = tileColor
                        .withAlpha(255); // Full opacity for multiple logs
                  } else {
                    tileColor = tileColor.withAlpha(
                        200); // Slightly reduced opacity for single log
                  }
                  tooltipText = completeCount > 1
                      ? "$completeCount habits completed"
                      : "1 habit completed";
                }
              }

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
                    widget.onDaySelected(dayLogs);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: index == selectedDay - 1
                            ? Get.theme.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
