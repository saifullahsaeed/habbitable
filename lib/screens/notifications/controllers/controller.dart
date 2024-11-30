import 'package:get/get.dart';
import 'package:habbitable/models/notification.dart';
import 'package:habbitable/repos/notifications.dart';

class NotificationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final NotificationsRepository notificationsRepository =
      NotificationsRepository();
  RxList<Notification> notifications = RxList<Notification>();
  RxBool isLoading = RxBool(false);
  Rx<NotificationType?> notificationType = Rx<NotificationType?>(null);
  Rx<NotificationCategory?> notificationCategory =
      Rx<NotificationCategory?>(null);
  Rx<NotificationPriority?> notificationPriority =
      Rx<NotificationPriority?>(null);

  //get notifications
  Future<void> getNotifications() async {
    isLoading.value = true;
    final response = await notificationsRepository.getNotifications();
    if (response.statusCode == 200) {
      notifications.value = response.data
          .map((n) => Notification.fromJson(n))
          .toList()
          .cast<Notification>();
      notifications.refresh();
    }
    isLoading.value = false;
  }
}
