import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/line_chart.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              LineChart(
                data: [7, 0, 1, 8, 3, 4, 5],
                height: 200,
                width: Get.width,
                title: 'Time Spent (Minutes)',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
