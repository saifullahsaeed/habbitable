import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:shimmer/shimmer.dart';

class TimeSpentChart extends StatefulWidget {
  final List<int> timeSpents;
  final bool hideTitle;
  final String title;
  final String subtitle;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? barColor;
  final Color? barBackgroundColor;
  final Color? touchedBarColor;
  final Color? barTextColor;
  final Color? dayLetterColor;

  TimeSpentChart({
    super.key,
    List<int>? timeSpents,
    this.hideTitle = false,
    this.title = 'Title',
    this.subtitle = 'Subtitle',
    this.titleColor,
    this.subtitleColor,
    this.barColor,
    this.barBackgroundColor,
    this.touchedBarColor,
    this.barTextColor,
    this.dayLetterColor,
  }) : timeSpents = timeSpents ?? [];

  @override
  State<StatefulWidget> createState() => TimeSpentChartState();
}

class TimeSpentChartState extends State<TimeSpentChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  List<String> weekDaysFull = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Get.textTheme.titleMedium!.copyWith(
                        color:
                            widget.titleColor ?? Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      minutesToHours(widget.timeSpents.reduce((a, b) => a + b)),
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: widget.subtitleColor ??
                            Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.subtitle,
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: BarChart(
                    mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    int maxTime = widget.timeSpents.isEmpty
        ? 0
        : widget.timeSpents.reduce((a, b) => max(a, b));
    double maxY;
    if (maxTime < 30) {
      maxY = 30;
    } else {
      maxY = maxTime.toDouble();
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: BorderSide.none,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    if (widget.timeSpents.isEmpty) {
      return [
        makeGroupData(0, 0, isTouched: false),
        makeGroupData(1, 0, isTouched: false),
        makeGroupData(2, 0, isTouched: false),
        makeGroupData(3, 0, isTouched: false),
        makeGroupData(4, 0, isTouched: false),
        makeGroupData(5, 0, isTouched: false),
        makeGroupData(6, 0, isTouched: false),
      ];
    }
    return widget.timeSpents.asMap().entries.map((entry) {
      return makeGroupData(entry.key, entry.value.toDouble(), isTouched: false);
    }).toList();
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Get.theme.colorScheme.primary,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: 10,
          tooltipHorizontalOffset: -20,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '${weekDaysFull[group.x]}\n',
              Get.textTheme.bodySmall!.copyWith(
                color: Get.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: minutesToHours(rod.toY.toInt()),
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Get.theme.colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        weekDays[value.toInt()],
        style: style,
      ),
    );
  }
}

class TimeSpentChartShimmer extends StatelessWidget {
  const TimeSpentChartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle shimmer
                  Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Chart bars shimmer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        7,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 22,
                              height: 80 + (index * 10 % 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Day letter shimmer
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
