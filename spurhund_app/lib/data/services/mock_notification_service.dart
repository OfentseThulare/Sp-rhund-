import '../../models/notification_item.dart';
import '../mock/mock_notifications.dart';

class MockNotificationService {
  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockNotifications;
  }
}
