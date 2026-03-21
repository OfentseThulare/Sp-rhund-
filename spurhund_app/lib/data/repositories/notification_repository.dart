import '../../models/notification_item.dart';
import '../services/mock_notification_service.dart';

class NotificationRepository {
  final MockNotificationService _service;

  NotificationRepository(this._service);

  Future<List<NotificationItem>> getNotifications() async {
    return await _service.fetchNotifications();
  }
}
