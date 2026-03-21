import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colours.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: SpuerhundColours.primary,
      primary: SpuerhundColours.primary,
      onPrimary: Colors.white,
      secondary: SpuerhundColours.primaryLight,
      surface: SpuerhundColours.background,
      onSurface: SpuerhundColours.textPrimary,
      error: SpuerhundColours.error,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: SpuerhundColours.background,

      // Typography
      fontFamily: GoogleFonts.manrope().fontFamily,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          letterSpacing: -1.5,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          letterSpacing: -1.0,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          letterSpacing: -0.5,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        headlineSmall: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.manrope(
          color: SpuerhundColours.textPrimary,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.manrope(
          color: SpuerhundColours.textSecondary,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.manrope(
          color: SpuerhundColours.textSecondary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: SpuerhundColours.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: SpuerhundColours.textPrimary),
        titleTextStyle: GoogleFonts.epilogue(
          color: SpuerhundColours.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: SpuerhundColours.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.xl),
        ),
        margin: EdgeInsets.zero,
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SpuerhundColours.surfaceMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.md),
          borderSide: BorderSide(
            color: SpuerhundColours.border,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.md),
          borderSide: BorderSide(
            color: SpuerhundColours.primary.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.md),
          borderSide: BorderSide(
            color: SpuerhundColours.error.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpuerhundRadius.md),
          borderSide: const BorderSide(
            color: SpuerhundColours.error,
            width: 2,
          ),
        ),
        labelStyle: GoogleFonts.manrope(
          color: SpuerhundColours.textSecondary,
        ),
        hintStyle: GoogleFonts.manrope(
          color: SpuerhundColours.textTertiary,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),

      // Bottom Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        indicatorColor: SpuerhundColours.primaryTint,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: SpuerhundColours.primary);
          }
          return const IconThemeData(color: SpuerhundColours.textTertiary);
        }),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: SpuerhundColours.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: SpuerhundColours.divider,
        thickness: 1,
        space: 1,
      ),

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
