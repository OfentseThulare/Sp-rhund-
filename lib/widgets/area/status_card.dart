import 'package:flutter/material.dart';
import '../../models/service_status.dart';
import '../../theme/colours.dart';
import '../common/status_badge.dart';

class StatusCard extends StatelessWidget {
  final ServiceAlert alert;

  const StatusCard({super.key, required this.alert});

  Color get _borderColor {
    switch (alert.alertType) {
      case AlertType.outage:
        return AppColours.crimson;
      case AlertType.maintenance:
        return AppColours.amber;
      case AlertType.resolved:
        return AppColours.emerald;
      case AlertType.loadshedding:
        return AppColours.primaryPurple;
      case AlertType.info:
        return const Color(0xFF3B82F6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: _borderColor, width: 3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(label: alert.alertType.displayName, color: _borderColor),
          const SizedBox(height: 8),
          Text(
            alert.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColours.nearBlack,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alert.area,
            style: const TextStyle(fontSize: 13, color: AppColours.slate),
          ),
          if (alert.description != null) ...[
            const SizedBox(height: 4),
            Text(
              alert.description!,
              style: const TextStyle(fontSize: 13, color: AppColours.slate),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
