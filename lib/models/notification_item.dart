class NotificationItem {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final bool read;
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.read = false,
    required this.createdAt,
  });

  NotificationItem copyWith({bool? read}) {
    return NotificationItem(
      id: id,
      title: title,
      body: body,
      type: type,
      read: read ?? this.read,
      createdAt: createdAt,
    );
  }
}

enum NotificationType {
  bill,
  payment,
  dispute,
  alert,
  info;
}
