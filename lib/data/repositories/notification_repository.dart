import '../../models/notification_item.dart';
import '../mock/mock_notifications.dart';

class NotificationRepository {
  List<NotificationItem> getNotifications() =>
      List.unmodifiable(mockNotifications);

  int get unreadCount => mockNotifications.where((n) => !n.read).length;
}
