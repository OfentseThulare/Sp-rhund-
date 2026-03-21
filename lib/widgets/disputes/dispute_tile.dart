import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/dispute.dart';
import '../../theme/colours.dart';
import '../common/status_badge.dart';

class DisputeTile extends StatelessWidget {
  final Dispute dispute;
  final VoidCallback? onTap;

  const DisputeTile({super.key, required this.dispute, this.onTap});

  StatusBadge get _badge {
    switch (dispute.status) {
      case DisputeStatus.submitted:
        return const StatusBadge(label: 'Submitted', color: AppColours.slate);
      case DisputeStatus.inProgress:
        return const StatusBadge(label: 'In Progress', color: AppColours.amber);
      case DisputeStatus.underReview:
        return StatusBadge(label: 'Under Review', color: const Color(0xFF3B82F6));
      case DisputeStatus.resolved:
        return const StatusBadge(label: 'Resolved', color: AppColours.emerald);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM yyyy');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColours.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dispute.ticketNumber,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColours.slate,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dispute.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColours.nearBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _badge,
                      const SizedBox(width: 8),
                      Text(
                        dateFormat.format(dispute.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColours.slate,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColours.fog),
          ],
        ),
      ),
    );
  }
}
