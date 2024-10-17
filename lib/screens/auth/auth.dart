import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/style/text.dart';
import 'package:habbitable/widgets/button.dart';

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
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/habit.jpg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
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
                      'Welcome to App',
                      style: titleTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'The best app to track your habits',
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
