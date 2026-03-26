import 'package:flutter/material.dart';

abstract final class AppColours {
  // Primary Accent
  static const Color primaryPurple = Color(0xFF8529E2);
  static const Color deepViolet = Color(0xFF6B1FB8);
  static const Color softLavender = Color(0xFFB07AEF);
  static const Color whisperPurple = Color(0xFFF3ECFD);

  // Dark Canvas System
  static const Color voidBlack = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color elevatedSurface = Color(0xFF222222);
  static const Color pureWhite = Color(0xFFFFFFFF);

  // Text Hierarchy (on dark)
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA); // Zinc 400
  static const Color textTertiary = Color(0xFF71717A); // Zinc 500 (4.54:1 on #0A0A0A)

  // Borders and Dividers
  static const Color divider = Color(0xFF2A2A2A);
  static Color borderSubtle = Colors.white.withValues(alpha: 0.05);
  static Color borderLight = Colors.white.withValues(alpha: 0.10);

  // Status
  static const Color emerald = Color(0xFF10B981);
  static const Color amber = Color(0xFFF59E0B);
  static const Color crimson = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glassmorphic
  static Color glassBackground = Colors.black.withValues(alpha: 0.80);
  static Color glassOverlay = Colors.white.withValues(alpha: 0.05);
  static Color glassOverlayMedium = Colors.white.withValues(alpha: 0.10);

  // Legacy aliases (for migration)
  static const Color nearBlack = textPrimary;
  static const Color slate = textSecondary;
  static const Color ash = textTertiary;
  static const Color fog = divider;
  static const Color cloudGrey = elevatedSurface;
}
