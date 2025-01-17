import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

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

    final AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.requestExactAlarmsPermission();

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: androidSettings,
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

  Future<void> scheduleNotification(
    String title,
    String body,
    DateTime date, {
    String? repeat = 'daily',
  }) async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final bool? hasPermission =
        await androidPlugin?.requestExactAlarmsPermission();

    if (hasPermission != true) {
      throw Exception('Exact alarms permission not granted');
    }

    initializeTimeZones();
    // Convert `DateTime` to `tz.TZDateTime`
    TZDateTime scheduledDate = TZDateTime.local(
        date.year, date.month, date.day, date.hour, date.minute);

    if (repeat == 'daily') {
      // Adjust time to repeat daily
      scheduledDate = _nextInstanceOfTime(date.hour, date.minute);
    } else if (repeat == 'weekly') {
      // Adjust time to repeat weekly
      scheduledDate =
          _nextInstanceOfWeekly(date.hour, date.minute, date.weekday);
    } else {
      return; // Unsupported repeat type
    }

    await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
      title.hashCode, // Unique ID
      title, // Notification title
      body, // Notification body
      const Duration(minutes: 1),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'Default Channel',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher', // Your app icon
        ),
      ),
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      // matchDateTimeComponents: repeat == 'daily'
      //     ? DateTimeComponents.time
      //     : DateTimeComponents.dayOfWeekAndTime,
    );

    //print all scheduled notifications
    final notifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(notifications.map((e) => e.title).toList());
  }

  TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = TZDateTime.now(local);
    var scheduledDate =
        TZDateTime.local(now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  TZDateTime _nextInstanceOfWeekly(int hour, int minute, int weekday) {
    TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelNotification(String title) async {
    await flutterLocalNotificationsPlugin.cancel(title.hashCode);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
