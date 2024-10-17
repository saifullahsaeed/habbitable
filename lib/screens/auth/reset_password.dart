import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/style/text.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';

class ResetPassword extends StatefulWidget {
  final String token;
  const ResetPassword({super.key, required this.token});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Set New Password',
                    textAlign: TextAlign.center,
                    style: titleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  buildInput(
                    label: 'New Password',
                    hint: 'Enter your new password',
                    inputType: TextInputType.visiblePassword,
                    controller: TextEditingController(),
                    isPassword: true,
                    context: context,
                  ),
                  const SizedBox(height: 10),
                  buildInput(
                    label: 'Confirm Password',
                    hint: 'Confirm your new password',
                    inputType: TextInputType.visiblePassword,
                    controller: TextEditingController(),
                    isPassword: true,
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width,
                    child: MainButton(
                      label: 'Reset Password',
                      icon: Icons.save,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
