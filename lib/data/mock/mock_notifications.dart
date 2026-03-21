import '../../models/notification_item.dart';

final mockNotifications = [
  NotificationItem(
    id: 'notif-001',
    title: 'Bill due in 5 days',
    body: 'Your February 2026 municipal account of R4,832.50 is due on 15 March.',
    type: NotificationType.bill,
    createdAt: DateTime(2026, 3, 10, 8, 0),
  ),
  NotificationItem(
    id: 'notif-002',
    title: 'Electricity outage in your area',
    body: 'Unplanned power outage affecting Sunnyside Block C to F since 06:30.',
    type: NotificationType.alert,
    createdAt: DateTime(2026, 3, 20, 6, 35),
  ),
  NotificationItem(
    id: 'notif-003',
    title: 'Dispute update',
    body: 'Your dispute #1042 (Incorrect water meter reading) has been updated to In Progress.',
    type: NotificationType.dispute,
    createdAt: DateTime(2026, 2, 20, 14, 0),
  ),
];
