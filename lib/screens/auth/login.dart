import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/auth/controllers/auth_controller.dart';
import 'package:habbitable/style/text.dart';
import 'package:habbitable/utils/validators.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';

class LoginScreen extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  LoginScreen({super.key});

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
              key: loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Login with your account ',
                    textAlign: TextAlign.center,
                    style: titleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  buildInput(
                    label: 'Email',
                    hint: 'Enter your email',
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    context: context,
                    validator: (value) => emailValidator(value),
                  ),
                  const SizedBox(height: 10),
                  buildInput(
                    label: 'Password',
                    hint: 'Enter your password',
                    inputType: TextInputType.visiblePassword,
                    controller: passwordController,
                    isPassword: true,
                    context: context,
                    validator: (value) => passwordValidator(value),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width,
                    child: MainButton(
                      label: 'Login',
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {
                          controller.login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      icon: Icons.login_rounded,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButtonCustom(
                        onPressed: () {
                          Get.toNamed('/auth/forgot');
                        },
                        label: 'Forgot Password?',
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/auth/signup');
                        },
                        child: const Text('Create Account'),
                      ),
                    ],
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
