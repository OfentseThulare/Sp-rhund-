import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colours.dart';

/// Premium status badge with refined colour mapping and pill shape.
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  (Color bg, Color text) _getColors() {
    return switch (status.toLowerCase()) {
      'paid' || 'current' || 'resolved' => (
        SpuerhundColours.successTint,
        SpuerhundColours.success,
      ),
      'due_soon' || 'warning' || 'in_progress' => (
        SpuerhundColours.warningTint,
        SpuerhundColours.warning,
      ),
      'overdue' || 'critical' => (
        SpuerhundColours.errorTint,
        SpuerhundColours.error,
      ),
      _ => (SpuerhundColours.surfaceMuted, SpuerhundColours.textSecondary),
    };
  }

  String _formatStatus() {
    return status.replaceAll('_', ' ').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor) = _getColors();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
      ),
      child: Text(
        _formatStatus(),
        style: GoogleFonts.manrope(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
