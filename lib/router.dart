import 'package:get/get.dart';
import 'package:habbitable/middlewares/auth_middleware.dart';
import 'package:habbitable/screens/auth/auth.dart';
import 'package:habbitable/screens/auth/controllers/auth_controller.dart';
import 'package:habbitable/screens/auth/forgot_password.dart';
import 'package:habbitable/screens/auth/login.dart';
import 'package:habbitable/screens/auth/reset_password.dart';
import 'package:habbitable/screens/auth/signup.dart';
import 'package:habbitable/screens/bottom_nav.dart';
import 'package:habbitable/screens/home.dart';
import 'package:habbitable/screens/settings.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => const BottomNav(),
    middlewares: [
      AuthMiddleware(),
    ],
  ),
  GetPage(
    name: '/settings',
    page: () => const SettingsScreen(),
    middlewares: [
      AuthMiddleware(),
    ],
  ),
  GetPage(
    name: '/auth',
    page: () => const AuthScreen(),
    children: [
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
        bindings: [
          BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ],
      ),
      GetPage(
        name: '/signup',
        page: () => const SignupScreen(),
        bindings: [
          BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ],
      ),
      GetPage(
        name: '/forgot',
        page: () => const ForgotPassword(),
        bindings: [
          BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ],
      ),
      GetPage(
        name: '/reset',
        page: () => ResetPassword(
          token: Get.parameters['token']!,
        ),
        bindings: [
          BindingsBuilder(() {
            Get.lazyPut(() => AuthController());
          }),
        ],
      ),
    ],
  ),
];
