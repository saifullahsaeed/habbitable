import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/local_storage.dart';
import 'package:habbitable/Services/sqlite.dart';
import 'package:habbitable/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LocalStorageService().init());
  await Get.putAsync(() => SqliteService().init());
  runApp(const MyApp());
}
