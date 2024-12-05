import 'package:get/get.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/middlewares/auth_middleware.dart';
import 'package:habbitable/screens/auth/auth.dart';
import 'package:habbitable/screens/auth/controllers/auth_controller.dart';
import 'package:habbitable/screens/auth/forgot_password.dart';
import 'package:habbitable/screens/auth/login.dart';
import 'package:habbitable/screens/auth/reset_password.dart';
import 'package:habbitable/screens/auth/signup.dart';
import 'package:habbitable/screens/bottom_nav.dart';
import 'package:habbitable/screens/community/club/club.dart';
import 'package:habbitable/screens/community/club/details.dart';
import 'package:habbitable/screens/community/controllers/search_controller.dart';
import 'package:habbitable/screens/community/my_friends.dart';
import 'package:habbitable/screens/community/received_requests.dart';
import 'package:habbitable/screens/community/search_user.dart';
import 'package:habbitable/screens/community/sent_requests.dart';
import 'package:habbitable/screens/community/social_settings.dart';
import 'package:habbitable/screens/habit/calender.dart';
import 'package:habbitable/screens/habit/controllers/controller.dart';
import 'package:habbitable/screens/habit/create.dart';
import 'package:habbitable/screens/habit/habit.dart';
import 'package:habbitable/screens/habit/users.dart';
import 'package:habbitable/screens/notifications/controllers/controller.dart';
import 'package:habbitable/screens/notifications/screen.dart';
import 'package:habbitable/screens/profile/controllers/profilecontroller.dart';
import 'package:habbitable/screens/profile/edit.dart';
import 'package:habbitable/screens/profile/profile.dart';
import 'package:habbitable/screens/settings.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => const BottomNav(),
    middlewares: [
      AuthMiddleware(),
    ],
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ],
  ),
  GetPage(
    name: '/settings',
    page: () => SettingsScreen(),
    middlewares: [
      AuthMiddleware(),
    ],
    children: [
      GetPage(
        name: '/social',
        page: () => SocialSettingsScreen(),
      ),
    ],
  ),
  GetPage(
    name: '/habit',
    page: () => HabitScreen(
      habit: Get.arguments['habit'],
    ),
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() => HabitScreenController());
      }),
    ],
    children: [
      GetPage(
        name: '/users',
        page: () => HabitUsersScreen(
          habit: Get.arguments['habit'],
        ),
        showCupertinoParallax: false,
      ),
    ],
  ),
  GetPage(
    name: '/createhabit',
    page: () => const CreateHabitScreen(),
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() => HabitScreenController());
      }),
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
  GetPage(
    name: '/editprofile',
    page: () => EditProfileScreen(
      user: Get.arguments['user'],
    ),
  ),
  GetPage(
    name: '/profile/:userId',
    page: () => ProfileScreen(),
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() =>
            ProfileController(userId: int.parse(Get.parameters['userId']!)));
      }),
    ],
  ),
  GetPage(
    name: '/searchuser',
    page: () => const SearchUserScreen(),
    showCupertinoParallax: false,
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() => SearchUserController());
      }),
    ],
  ),
  GetPage(
    name: '/sentrequests',
    page: () => const SentRequestsScreen(),
  ),
  GetPage(
    name: '/receivedrequests',
    page: () => const ReceivedRequestsScreen(),
  ),
  GetPage(
    name: '/myfriends',
    page: () => const MyFriendsScreen(),
  ),
  GetPage(
    name: '/calender',
    page: () => const HabitCalenderScreen(),
  ),
  GetPage(
    name: '/notifications',
    page: () => const NotificationsScreen(),
    bindings: [
      BindingsBuilder(() {
        Get.lazyPut(() => NotificationsController());
      }),
    ],
  ),
  GetPage(
    name: '/club/:clubId',
    page: () => ClubScreen(
      clubId: Get.parameters['clubId']!,
    ),
    children: [
      GetPage(
        name: '/details',
        page: () => ClubDetailsScreen(
          clubId: Get.parameters['clubId']!,
        ),
      ),
    ],
  ),
];
