import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/screens/auth/controllers/auth_controller.dart';
import 'package:habbitable/style/text.dart';
import 'package:habbitable/utils/validators.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();
  final AuthController controller = Get.find<AuthController>();
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
              key: signupFormKey,
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
                    'Create an account',
                    textAlign: TextAlign.center,
                    style: titleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  buildInput(
                    label: 'Name',
                    hint: 'Enter your name',
                    inputType: TextInputType.text,
                    controller: nameController,
                    validator: (value) => nameValidator(value),
                    context: context,
                  ),
                  const SizedBox(height: 10),
                  buildInput(
                    label: 'Email',
                    hint: 'Enter your email',
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) => emailValidator(value),
                    context: context,
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
                      label: 'Signup',
                      icon: Icons.person_add,
                      onPressed: () {
                        if (signupFormKey.currentState!.validate()) {
                          controller.signup(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/auth/login');
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
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
