import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/theme.dart';
import 'package:habbitable/style/text.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Get.width > 600 ? Axis.horizontal : Axis.vertical,
        children: [
          Flexible(
            flex: 3,
            child: Lottie.asset(
              Get.find<ThemeService>().theme == 2
                  ? "assets/animations/auth_dark.json"
                  : "assets/animations/auth.json",
              frameRate: FrameRate(30),
              height: Get.height,
              width: Get.width,
            ),
          ),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Habbitable',
                      style: titleTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Build habits and streaks with friends',
                      style: subtitleTextStyle,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: MainButton(
                            label: 'Sign in',
                            icon: Icons.login_rounded,
                            onPressed: () {
                              Get.toNamed('auth/login');
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MainButton(
                            label: 'Sign up',
                            icon: Icons.person_add_rounded,
                            onPressed: () {
                              Get.toNamed('auth/signup');
                            },
                            style: 'secondary',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //sign in with google
                    SizedBox(
                      width: Get.width,
                      child: GoogleButton(onPressed: () {}),
                    ),
                    //sign in with apple
                    SizedBox(
                      width: Get.width,
                      child: AppleButton(onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
