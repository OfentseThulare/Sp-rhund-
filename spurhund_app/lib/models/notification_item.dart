class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String type; // bill, payment, dispute, alert, info
  final bool isRead;
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    required this.createdAt,
  });
}
