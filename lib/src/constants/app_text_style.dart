import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Font weight constants for consistency.
class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Prevent instantiation
  AppFontWeight._();
}

/// Font size constants for consistency.
class AppFontSize {
  static const double xs = 10;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 20;
  static const double xxxl = 24;
  static const double display1 = 28;
  static const double display2 = 32;
  static const double display3 = 40;

  // Prevent instantiation
  AppFontSize._();
}

/// Pre-defined text styles for the application.
/// These adapt to the current theme (light/dark mode).
/// Use context.colors to get theme-aware colors.
class AppTextStyle {
  // Display styles
  static TextStyle get displayLarge => GoogleFonts.istokWeb(
    fontSize: AppFontSize.display3,
    fontWeight: AppFontWeight.bold,
  );

  static TextStyle get displayMedium => GoogleFonts.istokWeb(
    fontSize: AppFontSize.display2,
    fontWeight: AppFontWeight.bold,
  );

  static TextStyle get displaySmall => GoogleFonts.istokWeb(
    fontSize: AppFontSize.display1,
    fontWeight: AppFontWeight.bold,
  );

  // Headline styles
  static TextStyle get headlineLarge => GoogleFonts.istokWeb(
    fontSize: AppFontSize.xxxl,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle get headlineMedium => GoogleFonts.istokWeb(
    fontSize: AppFontSize.xxl,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle get headlineSmall => GoogleFonts.istokWeb(
    fontSize: AppFontSize.xl,
    fontWeight: AppFontWeight.semiBold,
  );

  // Title styles
  static TextStyle get titleLarge => GoogleFonts.istokWeb(
    fontSize: AppFontSize.lg,
    fontWeight: AppFontWeight.semiBold,
  );

  static TextStyle get titleMedium => GoogleFonts.istokWeb(
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.medium,
  );

  static TextStyle get titleSmall => GoogleFonts.istokWeb(
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.medium,
  );

  // Body styles
  static TextStyle get bodyLarge => GoogleFonts.istokWeb(
    fontSize: AppFontSize.lg,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle get bodyMedium => GoogleFonts.istokWeb(
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle get bodySmall => GoogleFonts.istokWeb(
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.regular,
  );

  // Label styles
  static TextStyle get labelLarge => GoogleFonts.istokWeb(
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.medium,
  );

  static TextStyle get labelMedium => GoogleFonts.istokWeb(
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.medium,
  );

  static TextStyle get labelSmall => GoogleFonts.istokWeb(
    fontSize: AppFontSize.xs,
    fontWeight: AppFontWeight.medium,
  );

  // Button text style
  static TextStyle get button => GoogleFonts.istokWeb(
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.semiBold,
  );

  // Caption style
  static TextStyle get caption => GoogleFonts.istokWeb(
    fontSize: AppFontSize.xs,
    fontWeight: AppFontWeight.regular,
  );

  // Prevent instantiation
  AppTextStyle._();
}

/// Creates the TextTheme for Material theme configuration.
TextTheme createTextTheme({
  required Color textColor,
  required Color secondaryTextColor,
}) {
  return GoogleFonts.istokWebTextTheme(
    TextTheme(
      displayLarge: AppTextStyle.displayLarge.copyWith(color: textColor),
      displayMedium: AppTextStyle.displayMedium.copyWith(color: textColor),
      displaySmall: AppTextStyle.displaySmall.copyWith(color: textColor),
      headlineLarge: AppTextStyle.headlineLarge.copyWith(color: textColor),
      headlineMedium: AppTextStyle.headlineMedium.copyWith(color: textColor),
      headlineSmall: AppTextStyle.headlineSmall.copyWith(color: textColor),
      titleLarge: AppTextStyle.titleLarge.copyWith(color: textColor),
      titleMedium: AppTextStyle.titleMedium.copyWith(color: textColor),
      titleSmall: AppTextStyle.titleSmall.copyWith(color: textColor),
      bodyLarge: AppTextStyle.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTextStyle.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTextStyle.bodySmall.copyWith(color: textColor),
      labelLarge: AppTextStyle.labelLarge.copyWith(color: textColor),
      labelMedium: AppTextStyle.labelMedium.copyWith(color: textColor),
      labelSmall: AppTextStyle.labelSmall.copyWith(color: secondaryTextColor),
    ),
  );
}
