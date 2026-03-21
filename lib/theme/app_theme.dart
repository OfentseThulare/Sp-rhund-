import 'package:flutter/material.dart';
import 'colours.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColours.primaryPurple,
      brightness: Brightness.light,
      primary: AppColours.primaryPurple,
      onPrimary: AppColours.pureWhite,
      surface: AppColours.pureWhite,
      onSurface: AppColours.nearBlack,
      error: AppColours.crimson,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColours.pureWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColours.pureWhite,
        foregroundColor: AppColours.nearBlack,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColours.nearBlack,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColours.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.04),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColours.primaryPurple,
          foregroundColor: AppColours.pureWhite,
          minimumSize: const Size(double.infinity, 52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColours.primaryPurple,
          side: const BorderSide(color: AppColours.primaryPurple),
          minimumSize: const Size(double.infinity, 52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColours.cloudGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColours.primaryPurple, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: AppColours.slate),
        hintStyle: const TextStyle(color: AppColours.ash),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColours.pureWhite,
        indicatorColor: AppColours.whisperPurple,
        surfaceTintColor: Colors.transparent,
        height: 56,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColours.primaryPurple,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const TextStyle(
            color: AppColours.softLavender,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColours.primaryPurple, size: 24);
          }
          return const IconThemeData(color: AppColours.softLavender, size: 24);
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColours.fog,
        thickness: 0.5,
        space: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColours.cloudGrey,
        selectedColor: AppColours.primaryPurple,
        labelStyle: const TextStyle(fontSize: 14),
        shape: const StadiumBorder(),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
