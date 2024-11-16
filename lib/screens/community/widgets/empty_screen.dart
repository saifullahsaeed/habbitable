import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptySocialScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const EmptySocialScreen(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/animations/Info.json",
              height: 100,
              repeat: true,
            ),
            Text(
              title,
              style: Get.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
