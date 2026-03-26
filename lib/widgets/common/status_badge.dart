import 'package:flutter/material.dart';
import '../../theme/colours.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
  });

  factory StatusBadge.paid() =>
      const StatusBadge(label: 'Paid', color: AppColours.emerald);

  factory StatusBadge.unpaid() =>
      const StatusBadge(label: 'Unpaid', color: AppColours.crimson);

  factory StatusBadge.current() =>
      const StatusBadge(label: 'Current', color: AppColours.emerald);

  factory StatusBadge.dueSoon() =>
      const StatusBadge(label: 'Due Soon', color: AppColours.amber);

  factory StatusBadge.overdue() =>
      const StatusBadge(label: 'Overdue', color: AppColours.crimson);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
