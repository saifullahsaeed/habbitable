import 'dart:math';

import 'package:flutter/material.dart';

class LineChart extends StatefulWidget {
  final List<double> data;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color lineColor;
  final double lineWidth;
  final String? title;
  final TextStyle? titleStyle;
  const LineChart({
    super.key,
    required this.data,
    required this.height,
    required this.width,
    this.backgroundColor = Colors.white,
    this.lineColor = Colors.blue,
    this.lineWidth = 2,
    this.title,
    this.titleStyle,
  });

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    labels = _generateLabels(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Column(
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: widget.titleStyle ??
                  const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),
            ),
          _paintAreaChart(),
        ],
      ),
    );
  }

  Widget _paintAreaChart() {
    return CustomPaint(
      size: Size(widget.width, widget.height - 14),
      painter: LineChartPainter(
        data: widget.data,
        lineColor: widget.lineColor,
        lineWidth: widget.lineWidth,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;
  LineChartPainter({
    required this.data,
    required this.lineColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Add padding to prevent overflow
    final horizontalPadding = size.width * 0.05;
    final verticalPadding = size.height * 0.1;

    // Adjust available space to account for line width
    final availableWidth = size.width - (2 * horizontalPadding) - lineWidth;
    final availableHeight = size.height - (2 * verticalPadding) - lineWidth;

    final unitWidth = availableWidth / (data.length - 1);
    final maxDataPoint = data.reduce(max);
    final minDataPoint = data.reduce(min);
    final dataRange = maxDataPoint - minDataPoint;
    final unitHeight = availableHeight / dataRange;

    List<Offset> points = [];

    for (var i = 0; i < data.length; i++) {
      final x = horizontalPadding + (i * unitWidth) + (lineWidth / 2);
      final y = size.height -
          verticalPadding -
          ((data[i] - minDataPoint) * unitHeight) -
          (lineWidth / 2);
      points.add(Offset(x, y));
    }

    // Create smooth curve
    _createSmoothCurve(path, points, unitWidth);

    // Clip the path to the chart area, accounting for line width
    final chartRect = Rect.fromLTWH(
      horizontalPadding + (lineWidth / 2),
      verticalPadding + (lineWidth / 2),
      availableWidth,
      availableHeight,
    );
    canvas.clipRect(chartRect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _createSmoothCurve(Path path, List<Offset> points, double unitWidth) {
    for (var i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        final p0 = points[i - 1];
        final p1 = points[i];
        final controlPoint1 = Offset((p0.dx + unitWidth / 2) - 1, p0.dy);
        final controlPoint2 = Offset((p1.dx - unitWidth / 2) + 1, p1.dy);
        path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
            controlPoint2.dy, p1.dx, p1.dy);
      }
    }
  }
}

List<String> _generateLabels(List<double> data) {
  return List.generate(data.length, (index) => index.toString());
}
