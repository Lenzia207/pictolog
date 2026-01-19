import 'package:flutter/material.dart';
import 'app_color.dart';

/// Font family constant for the application.
class AppFont {
  static const String primary = 'Istok Web';

  // Prevent instantiation
  AppFont._();
}

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
/// These use the default text color (black for light theme).
/// Use .copyWith(color: ...) to change colors when needed.
class AppTextStyle {
  // Display styles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.display3,
    fontWeight: AppFontWeight.bold,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.display2,
    fontWeight: AppFontWeight.bold,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.display1,
    fontWeight: AppFontWeight.bold,
    color: AppColor.textPrimaryLight,
  );

  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.xxxl,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.xxl,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.xl,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimaryLight,
  );

  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.lg,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimaryLight,
  );

  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.lg,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textPrimaryLight,
  );

  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimaryLight,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.xs,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimaryLight,
  );

  // Button text style
  static const TextStyle button = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimaryLight,
  );

  // Caption style
  static const TextStyle caption = TextStyle(
    fontFamily: AppFont.primary,
    fontSize: AppFontSize.xs,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textSecondaryLight,
  );

  // Prevent instantiation
  AppTextStyle._();
}

/// Creates the TextTheme for Material theme configuration.
TextTheme createTextTheme({
  required Color textColor,
  required Color secondaryTextColor,
}) {
  return TextTheme(
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
  );
}
