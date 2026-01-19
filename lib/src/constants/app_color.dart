import 'package:flutter/material.dart';

/// A class that defines the color palette for the application.
/// These are the raw color values used throughout the app.
class AppColor {
  // Primary colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Background colors
  static const Color backgroundLight = Color(0xFFF2F4F5);
  static const Color backgroundDark = Color(0xFF121212);

  // Surface colors (for cards, dialogs, etc.)
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF797E85);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Accent color
  static const Color accentGreen = Color(0xFFC0E859);
  static const Color accentRed = Color(0xFFD04053);

  // Semantic colors
  static const Color error = Color(0xFFD04053);
  static const Color success = Color(0xFF4AA345);
  static const Color warning = Color(0xFFD07040);

  // Prevent instantiation
  AppColor._();
}

/// Theme-aware color scheme that adapts to light/dark mode.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color primary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color contrast;
  final Color accentGreen;
  final Color accentRed;

  const AppThemeColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.contrast,
    required this.accentGreen,
    required this.accentRed,
  });

  // Light theme colors
  static const light = AppThemeColors(
    primary: AppColor.black,
    background: AppColor.backgroundLight,
    surface: AppColor.surfaceLight,
    textPrimary: AppColor.textPrimaryLight,
    textSecondary: AppColor.textSecondaryLight,
    contrast: AppColor.white,
    accentGreen: AppColor.accentGreen,
    accentRed: AppColor.accentRed,
  );

  // Dark theme colors
  static const dark = AppThemeColors(
    primary: AppColor.white,
    background: AppColor.backgroundDark,
    surface: AppColor.surfaceDark,
    textPrimary: AppColor.textPrimaryDark,
    textSecondary: AppColor.textSecondaryDark,
    contrast: AppColor.black,
    accentGreen: AppColor.accentGreen,
    accentRed: AppColor.accentRed,
  );

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? contrast,
    Color? accentGreen,
    Color? accentRed,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      contrast: contrast ?? this.contrast,
      accentGreen: accentGreen ?? this.accentGreen,
      accentRed: accentRed ?? this.accentRed,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      contrast: Color.lerp(contrast, other.contrast, t)!,
      accentGreen: Color.lerp(accentGreen, other.accentGreen, t)!,
      accentRed: Color.lerp(accentRed, other.accentRed, t)!,
    );
  }
}

/// Extension to easily access theme colors from BuildContext.
extension AppThemeColorsExtension on BuildContext {
  AppThemeColors get colors =>
      Theme.of(this).extension<AppThemeColors>() ?? AppThemeColors.light;
}
