import 'package:flutter/material.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool isUnread;

  const _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    required this.isUnread,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static final _notifications = [
    _NotificationItem(
      icon: Icons.receipt_long_rounded,
      color: AppColours.info,
      title: 'New bill received',
      body: 'Your March 2026 municipal statement is ready to view.',
      time: '2 hours ago',
      isUnread: true,
    ),
    _NotificationItem(
      icon: Icons.alarm_rounded,
      color: AppColours.amber,
      title: 'Payment due in 3 days',
      body: 'Your electricity account of R 892.45 is due on 15 April.',
      time: '5 hours ago',
      isUnread: true,
    ),
    _NotificationItem(
      icon: Icons.update_rounded,
      color: AppColours.primaryPurple,
      title: 'Dispute status updated',
      body:
          'Your water billing dispute #WD-2026-0041 has been escalated to review.',
      time: '1 day ago',
      isUnread: false,
    ),
    _NotificationItem(
      icon: Icons.flash_on_rounded,
      color: AppColours.amber,
      title: 'Load shedding alert',
      body: 'Stage 2 load shedding starts at 16:00 today. Your area: Block 4.',
      time: '1 day ago',
      isUnread: false,
    ),
    _NotificationItem(
      icon: Icons.check_circle_rounded,
      color: AppColours.emerald,
      title: 'Payment confirmed',
      body:
          'Your payment of R 1,247.00 for rates & taxes has been received.',
      time: '3 days ago',
      isUnread: false,
    ),
    _NotificationItem(
      icon: Icons.water_drop_rounded,
      color: AppColours.info,
      title: 'Water maintenance scheduled',
      body:
          'Planned maintenance in Sunnyside on 28 March, 08:00 to 14:00.',
      time: '4 days ago',
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColours.voidBlack,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColours.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Semantics(
          header: true,
          child: Text(
            'Notifications',
            style: AppTypography.headlineSmall,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationCard(notification: notification);
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItem notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        border: Border.all(color: AppColours.borderSubtle),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notification.isUnread) ...[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 17),
              decoration: const BoxDecoration(
                color: AppColours.primaryPurple,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: notification.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              notification.icon,
              color: notification.color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: AppTypography.amountMedium.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.time,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColours.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
