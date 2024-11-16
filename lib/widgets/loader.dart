import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loader.json',
        frameRate: FrameRate.max,
        repeat: true,
        width: 100,
        height: 100,
      ),
    );
  }
}
