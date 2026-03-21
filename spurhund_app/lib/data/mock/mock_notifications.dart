import '../../models/notification_item.dart';

final List<NotificationItem> mockNotifications = [
  NotificationItem(
    id: "notif_1",
    title: "New Bill Available",
    body: "Your February 2026 statement is now available.",
    type: "bill",
    createdAt: DateTime(2026, 2, 20),
  ),
  NotificationItem(
    id: "notif_2",
    title: "Payment Received",
    body: "Thank you for your payment of R4,156.20.",
    type: "payment",
    isRead: true,
    createdAt: DateTime(2026, 2, 10),
  ),
  NotificationItem(
    id: "notif_3",
    title: "Load Shedding Alert",
    body: "Stage 2 loadshedding will be implemented today.",
    type: "alert",
    createdAt: DateTime.now(),
  ),
];
