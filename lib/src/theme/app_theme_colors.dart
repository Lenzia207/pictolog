import 'package:flutter/material.dart';

import 'app_color.dart';

/// Theme-aware color scheme that adapts to light/dark mode.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color primary;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textBody;
  final Color textSecondary;
  final Color contrast;
  final Color placeholder;
  final Color placeholderMuted;
  final Color outline;
  final Color outlineStrong;
  final Color accentGreen;
  final Color accentRed;

  const AppThemeColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textBody,
    required this.textSecondary,
    required this.contrast,
    required this.placeholder,
    required this.placeholderMuted,
    required this.outline,
    required this.outlineStrong,
    required this.accentGreen,
    required this.accentRed,
  });

  // Light theme colors
  static const light = AppThemeColors(
    primary: AppColor.black,
    background: AppColor.backgroundLight,
    surface: AppColor.surfaceLight,
    surfaceVariant: AppColor.backgroundLight,
    textPrimary: AppColor.textPrimaryLight,
    textBody: AppColor.textBodyLight,
    textSecondary: AppColor.textSecondaryLight,
    contrast: AppColor.white,
    placeholder: AppColor.placeholderLight,
    placeholderMuted: AppColor.placeholderMutedLight,
    outline: AppColor.outlineLight,
    outlineStrong: AppColor.outlineStrongLight,
    accentGreen: AppColor.accentGreen,
    accentRed: AppColor.accentRed,
  );

  // Dark theme colors
  static const dark = AppThemeColors(
    primary: AppColor.white,
    background: AppColor.backgroundDark,
    surface: AppColor.surfaceDark,
    surfaceVariant: AppColor.surfaceVariantDark,
    textPrimary: AppColor.textPrimaryDark,
    textBody: AppColor.textBodyDark,
    textSecondary: AppColor.textSecondaryDark,
    contrast: AppColor.black,
    placeholder: AppColor.placeholderDark,
    placeholderMuted: AppColor.placeholderMutedDark,
    outline: AppColor.outlineDark,
    outlineStrong: AppColor.outlineStrongDark,
    accentGreen: AppColor.accentGreen,
    accentRed: AppColor.accentRed,
  );

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? textPrimary,
    Color? textBody,
    Color? textSecondary,
    Color? contrast,
    Color? placeholder,
    Color? placeholderMuted,
    Color? outline,
    Color? outlineStrong,
    Color? accentGreen,
    Color? accentRed,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textBody: textBody ?? this.textBody,
      textSecondary: textSecondary ?? this.textSecondary,
      contrast: contrast ?? this.contrast,
      placeholder: placeholder ?? this.placeholder,
      placeholderMuted: placeholderMuted ?? this.placeholderMuted,
      outline: outline ?? this.outline,
      outlineStrong: outlineStrong ?? this.outlineStrong,
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
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textBody: Color.lerp(textBody, other.textBody, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      contrast: Color.lerp(contrast, other.contrast, t)!,
      placeholder: Color.lerp(placeholder, other.placeholder, t)!,
      placeholderMuted: Color.lerp(
        placeholderMuted,
        other.placeholderMuted,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineStrong: Color.lerp(outlineStrong, other.outlineStrong, t)!,
      accentGreen: Color.lerp(accentGreen, other.accentGreen, t)!,
      accentRed: Color.lerp(accentRed, other.accentRed, t)!,
    );
  }
}
