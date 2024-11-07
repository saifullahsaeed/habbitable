import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaysOfWeekSelector extends StatefulWidget {
  final List<String> selectedDays;
  final void Function(String) onChanged;
  const DaysOfWeekSelector(
      {super.key, required this.selectedDays, required this.onChanged});

  @override
  State<DaysOfWeekSelector> createState() => _DaysOfWeekSelectorState();
}

class _DaysOfWeekSelectorState extends State<DaysOfWeekSelector> {
  List<String> days = [
    'sun',
    'mon',
    'tue',
    'wed',
    'thu',
    'fri',
    'sat',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.theme.colorScheme.surface,
          ),
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 7,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(7, (index) {
              return InkWell(
                onTap: () {
                  widget.onChanged(days[index]);
                },
                splashColor: Get.theme.colorScheme.primary.withOpacity(0.5),
                child: Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.selectedDays.contains(days[index])
                        ? Get.theme.colorScheme.primary
                        : Get.theme.cardColor,
                  ),
                  child: Center(
                    child: Text(
                      days[index].toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: widget.selectedDays.contains(days[index])
                            ? Get.theme.colorScheme.onPrimary
                            : Get.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
