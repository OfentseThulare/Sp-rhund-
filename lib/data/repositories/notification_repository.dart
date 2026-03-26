import '../../models/notification_item.dart';
import '../mock/mock_notifications.dart';
import 'interfaces/i_notification_repository.dart';

class NotificationRepository implements INotificationRepository {
  @override
  List<NotificationItem> getNotifications() =>
      List.unmodifiable(mockNotifications);

  @override
  int get unreadCount => mockNotifications.where((n) => !n.read).length;
}
