import 'package:flutter/material.dart';

class SpuerhundColours {
  // Brand Primary
  static const Color primary = Color(0xFF8529E2);
  static const Color primaryDark = Color(0xFF6B1FB8);
  static const Color primaryLight = Color(0xFFB07AEF);
  static const Color primaryTint = Color(0xFF1C0A3A);

  // Surfaces — Deep black palette
  static const Color background = Color(0xFF0A0A0A);
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surface = Color(0xFF111111);
  static const Color surfaceMuted = Color(0xFF1A1A1A);
  static const Color surfaceElevated = Color(0xFF161616);

  // Text Hierarchy — Inverted for dark theme
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color successTint = Color(0xFF0A1F13);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningTint = Color(0xFF1F1600);
  static const Color error = Color(0xFFEF4444);
  static const Color errorTint = Color(0xFF1F0A0A);

  // Structural
  static const Color divider = Color(0xFF2A2A2A);
  static const Color border = Color(0xFF1E1E1E);
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassInnerBorder = Color(0x0DFFFFFF);
}

/// Premium shadow presets — tinted purple glow for dark backgrounds.
class SpuerhundShadows {
  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get card => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> get elevated => [
    BoxShadow(
      color: SpuerhundColours.primary.withValues(alpha: 0.20),
      blurRadius: 40,
      offset: const Offset(0, 12),
      spreadRadius: -8,
    ),
  ];

  static List<BoxShadow> get floating => [
    BoxShadow(
      color: SpuerhundColours.primary.withValues(alpha: 0.15),
      blurRadius: 48,
      offset: const Offset(0, 16),
      spreadRadius: -12,
    ),
  ];
}

/// Spacing scale for consistent rhythm.
class SpuerhundSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

/// Border radius scale for consistent squircle feel.
class SpuerhundRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double pill = 100;
}

/// Premium animation curves. No linear or basic ease-in-out.
class SpuerhundCurves {
  /// Smooth deceleration, feels weighty and premium.
  static const Curve premium = Cubic(0.32, 0.72, 0, 1);

  /// Spring-like overshoot for playful entrances.
  static const Curve spring = Cubic(0.34, 1.56, 0.64, 1);

  /// Snappy response for micro-interactions.
  static const Curve snappy = Cubic(0.25, 0.1, 0.25, 1);

  /// Gentle deceleration for fades and exits.
  static const Curve gentle = Cubic(0.4, 0, 0.2, 1);
}

/// Standard animation durations.
class SpuerhundDurations {
  static const Duration micro = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration entrance = Duration(milliseconds: 800);
}
