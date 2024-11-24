import 'package:get/get.dart';
import 'package:habbitable/models/notification.dart';
import 'package:habbitable/repos/notifications.dart';

class NotificationsController extends GetxController {
  final NotificationsRepository notificationsRepository =
      NotificationsRepository();
  RxList<Notification> notifications = RxList<Notification>();

  //get notifications
  Future<void> getNotifications() async {
    final response = await notificationsRepository.getNotifications();
    if (response.statusCode == 200) {
      notifications.value = response.data
          .map((n) => Notification.fromJson(n))
          .toList()
          .cast<Notification>();
      notifications.refresh();
    }
  }
}
