import 'package:flutter/material.dart';
import 'package:habbitable/models/notification.dart';
import 'package:habbitable/screens/notifications/controllers/controller.dart';
import 'package:line_icons/line_icons.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.controller,
  });
  final NotificationsController controller;
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    Color getColor(NotificationCategory category) {
      switch (category) {
        case NotificationCategory.alert:
          return Colors.red;
        case NotificationCategory.update:
          return Colors.blue;
        case NotificationCategory.promotion:
          return Colors.green;
        case NotificationCategory.system:
          return Colors.purple;
        default:
          return Theme.of(context).colorScheme.primary;
      }
    }

    IconData getIcon(NotificationCategory category) {
      switch (category) {
        case NotificationCategory.all:
          return LineIcons.bell;
        case NotificationCategory.promotion:
          return LineIcons.gift;
        case NotificationCategory.update:
          return LineIcons.bell;
        case NotificationCategory.alert:
          return LineIcons.exclamationTriangle;
        case NotificationCategory.system:
          return LineIcons.cog;
        default:
          return LineIcons.bell;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Badge(
        backgroundColor: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.all(4),
        offset: const Offset(10, -10),
        isLabelVisible: !notification.read,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        alignment: Alignment.topLeft,
        child: ListTile(
          onTap: () => controller.readNotification(notification.id),
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          dense: true,
          selected: !notification.read,
          selectedTileColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: getColor(notification.category).withOpacity(0.3),
            child: Icon(
              getIcon(notification.category),
              size: 24,
              color: getColor(notification.category),
            ),
          ),
          minLeadingWidth: 40,
          title: Text(
            notification.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            notification.message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
