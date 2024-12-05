import 'package:get/get.dart';
import 'package:habbitable/models/notification.dart';
import 'package:habbitable/repos/notifications.dart';

class NotificationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final NotificationsRepository notificationsRepository =
      NotificationsRepository();
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  RxBool isLoading = RxBool(false);
  Rx<NotificationCategory> selectedCategory =
      Rx<NotificationCategory>(NotificationCategory.all);
  Rx<NotificationType?> notificationType = Rx<NotificationType?>(null);
  Rx<NotificationCategory?> notificationCategory =
      Rx<NotificationCategory?>(null);
  Rx<NotificationPriority?> notificationPriority =
      Rx<NotificationPriority?>(null);

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  //get notifications
  Future<void> getNotifications() async {
    isLoading.value = true;
    final response = await notificationsRepository.getNotifications();
    if (response.statusCode == 200) {
      notifications.value = response.data
          .map((n) => NotificationModel.fromJson(n))
          .toList()
          .cast<NotificationModel>();
      notifications.refresh();
    }
    isLoading.value = false;
  }

  //read notification
  Future<void> readNotification(int id) async {
    notifications.firstWhere((n) => n.id == id).read = true;
    notifications.refresh();
    notificationsRepository.readNotification(id.toString());
  }
}
