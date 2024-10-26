import 'dart:convert';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;
  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      await _prefs.setString(key, jsonEncode(value));
    } else {
      throw Exception('Unsupported data type');
    }
  }

  dynamic getData(String key) {
    return _prefs.get(key);
  }

  Future<bool> removeData(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clearData() async {
    return await _prefs.clear();
  }
}
