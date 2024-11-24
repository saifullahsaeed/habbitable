import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';
import 'package:habbitable/Services/notifications.dart';
import 'package:habbitable/app.dart';
import 'package:habbitable/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => LocalStorageService().init());
  await Get.putAsync(() => NotificationsService().init());
  runApp(const MyApp());
}
