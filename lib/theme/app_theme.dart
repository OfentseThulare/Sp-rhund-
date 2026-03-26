import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colours.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColours.primaryPurple,
      brightness: Brightness.dark,
      primary: AppColours.primaryPurple,
      onPrimary: AppColours.pureWhite,
      surface: AppColours.surface,
      onSurface: AppColours.textPrimary,
      error: AppColours.crimson,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColours.voidBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColours.voidBlack,
        foregroundColor: AppColours.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: AppColours.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColours.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColours.borderSubtle),
        ),
        shadowColor: Colors.transparent,
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
        fillColor: AppColours.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColours.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColours.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColours.primaryPurple, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: AppColours.textSecondary),
        hintStyle: const TextStyle(color: AppColours.textTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColours.divider,
        thickness: 0.5,
        space: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColours.surface,
        selectedColor: AppColours.primaryPurple,
        labelStyle: const TextStyle(fontSize: 14, color: AppColours.textPrimary),
        shape: const StadiumBorder(),
        side: BorderSide(color: AppColours.borderLight),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColours.elevatedSurface,
        contentTextStyle: const TextStyle(
          color: AppColours.textPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColours.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }

  // Keep legacy accessor for any existing references
  static ThemeData get light => dark;
}
