import 'package:dio/dio.dart';
import 'package:habbitable/utils/api_client.dart';

class NotificationsRepository {
  final HttpWrapper httpWrapper;
  final String base = "notifications/";
  NotificationsRepository() : httpWrapper = HttpWrapper();

  //get all notifications
  Future<Response> getNotifications({
    int limit = 50,
    int offset = 0,
  }) async {
    String url = '$base?limit=$limit&offset=$offset';
    return await httpWrapper.get(url);
  }

  //read all notifications
  Future<Response> readNotifications() async {
    return await httpWrapper.post('${base}read');
  }

  //dismiss notification
  Future<Response> dismissNotification(String id) async {
    return await httpWrapper.post('${base}dismiss/$id');
  }

  //read notification
  Future<Response> readNotification(String id) async {
    return await httpWrapper.patch('${base}read/$id');
  }

  //clear notifications
  Future<Response> clearNotifications() async {
    return await httpWrapper.delete(base);
  }

  //remove notification
  Future<Response> removeNotification(String id) async {
    return await httpWrapper.delete('$base$id');
  }

  Future<Response> setFcmToken(String token) async {
    return await httpWrapper
        .post('${base}device-token', data: {'deviceToken': token});
  }

  //delete fcm token
  Future<Response> deleteFcmToken(String token) async {
    return await httpWrapper
        .delete('${base}device-token', data: {'deviceToken': token});
  }

  //clear all notifications
  Future<Response> clearNotificationsTokens() async {
    return await httpWrapper.delete('${base}device-token/clear');
  }
}
