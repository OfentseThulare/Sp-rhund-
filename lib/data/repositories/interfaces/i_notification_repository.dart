import '../../../models/notification_item.dart';

abstract class INotificationRepository {
  List<NotificationItem> getNotifications();
  int get unreadCount;
}
