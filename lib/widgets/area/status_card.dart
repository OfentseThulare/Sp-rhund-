import 'package:flutter/material.dart';
import '../../models/service_status.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
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
        return AppColours.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: _borderColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(label: alert.alertType.displayName, color: _borderColor),
          const SizedBox(height: 8),
          Text(
            alert.title,
            style: AppTypography.amountMedium.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alert.area,
            style: AppTypography.bodySmall.copyWith(fontSize: 13),
          ),
          if (alert.description != null) ...[
            const SizedBox(height: 4),
            Text(
              alert.description!,
              style: AppTypography.bodySmall.copyWith(fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
