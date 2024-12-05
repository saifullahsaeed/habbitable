enum NotificationType {
  info,
  success,
  warning,
  error,
}

enum NotificationCategory {
  all,
  promotion,
  update,
  alert,
  system,
  other,
}

enum NotificationPriority {
  normal,
  high,
}

class NotificationModel {
  final int id;
  final int userId;
  final NotificationType type;
  final NotificationCategory category;
  final NotificationPriority priority;
  final String title;
  final String message;
  bool read;
  final String? link;
  final String? metadata;
  final bool dismissed;
  final DateTime createdAt;
  final DateTime? readAt;
  final DateTime? expiresAt;

  NotificationModel({
    required this.id,
    required this.userId,
    this.type = NotificationType.info,
    this.category = NotificationCategory.other,
    this.priority = NotificationPriority.normal,
    required this.title,
    required this.message,
    this.read = false,
    this.link,
    this.metadata,
    this.dismissed = false,
    required this.createdAt,
    this.readAt,
    this.expiresAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.info,
      ),
      category: NotificationCategory.values.firstWhere(
        (e) => e.toString() == 'NotificationCategory.${json['category']}',
        orElse: () => NotificationCategory.other,
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.toString() == 'NotificationPriority.${json['priority']}',
        orElse: () => NotificationPriority.normal,
      ),
      title: json['title'] as String,
      message: json['message'] as String,
      read: json['read'] as bool,
      link: json['link'] as String?,
      metadata: json['metadata'] as String?,
      dismissed: json['dismissed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }
}
