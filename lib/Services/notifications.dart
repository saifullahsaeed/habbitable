import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message here
}

class NotificationsService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseInAppMessaging firebaseInAppMessaging =
      FirebaseInAppMessaging.instance;
  final StreamController<RemoteMessage> _messageStreamController =
      StreamController<RemoteMessage>.broadcast();

  Future<NotificationsService> init() async {
    await _initializeNotifications();
    return this;
  }

  Future<void> _initializeNotifications() async {
    await getFcmToken();
    await requestNotificationPermission();
    await _initLocalNotifications();
    await _setupFirebaseMessaging();
    await initInAppMessaging();
    await subscribeToTopic('guest');
  }

  Future<void> requestNotificationPermission() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initLocalNotifications() async {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: initializationSettingsDarwin,
      ),
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );
  }

  Future<void> _handleNotificationResponse(
      NotificationResponse response) async {
    if (response.payload != null && response.payload!.isNotEmpty) {
      Get.toNamed(response.payload!);
    }
  }

  Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _messageStreamController.sink.add(message);

    if (message.data['type'] == 'new_message') {
      _showNewMessageSnackbar(message);
    } else {
      _showLocalNotification(message);
    }
  }

  void _showNewMessageSnackbar(RemoteMessage message) {
    Get.snackbar(
      'New Message',
      message.notification?.body ?? '',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'Default Channel',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
        ),
      ),
      payload: message.data['link'],
    );
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    if (message.data['link'] != null) {
      Get.toNamed(message.data['link']);
    }
  }

  Future<void> initInAppMessaging() async {
    await firebaseInAppMessaging.triggerEvent('app_open');
  }

  Future<String?> getFcmToken() async {
    String? token = await firebaseMessaging.getToken();
    return token;
  }

  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  void onClose() {
    _messageStreamController.close();
    super.onClose();
  }
}
