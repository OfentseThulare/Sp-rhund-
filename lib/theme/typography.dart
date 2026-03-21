import 'package:flutter/material.dart';
import 'colours.dart';

abstract final class AppTypography {
  // Headlines
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColours.nearBlack,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColours.nearBlack,
    height: 1.25,
    letterSpacing: -0.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColours.nearBlack,
    height: 1.3,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColours.nearBlack,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColours.nearBlack,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColours.slate,
    height: 1.5,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColours.slate,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColours.slate,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Numeric display
  static const TextStyle balanceDisplay = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColours.pureWhite,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static const TextStyle amountMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColours.nearBlack,
    height: 1.3,
  );
}
