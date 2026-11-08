import 'package:flutter/material.dart';

/// The app's typeface, bundled in assets/fonts.
const String appFontFamily = 'IstokWeb';

/// Font weight constants for consistency.
/// Istok Web ships in regular and bold only.
class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight bold = FontWeight.w700;

  // Prevent instantiation
  AppFontWeight._();
}

/// Font size constants for consistency.
class AppFontSize {
  static const double xs = 11;
  static const double sm = 12;
  static const double caption = 13;
  static const double md = 14;
  static const double button = 15;
  static const double lg = 16;
  static const double navTitle = 17;
  static const double section = 18;
  static const double emptyTitle = 20;
  static const double sheetTitle = 22;
  static const double title = 26;
  static const double display = 30;

  // Prevent instantiation
  AppFontSize._();
}

/// Pre-defined text styles for the application.
/// These adapt to the current theme (light/dark mode).
/// Use context.colors to get theme-aware colors.
class AppTextStyle {
  // Screen title on top-level tabs ("Pictologs", "Settings")
  static TextStyle get display => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.display,
    height: 36 / AppFontSize.display,
    fontWeight: AppFontWeight.bold,
    letterSpacing: -0.3,
  );

  // Title of a pictolog or a form
  static TextStyle get title => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.title,
    height: 32 / AppFontSize.title,
    fontWeight: AppFontWeight.bold,
    letterSpacing: -0.26,
  );

  // Title inside bottom sheets
  static TextStyle get sheetTitle => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.sheetTitle,
    height: 28 / AppFontSize.sheetTitle,
    fontWeight: AppFontWeight.bold,
  );

  // Title of an empty state card
  static TextStyle get emptyTitle => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.emptyTitle,
    height: 26 / AppFontSize.emptyTitle,
    fontWeight: AppFontWeight.bold,
  );

  // Section heading ("Pages")
  static TextStyle get section => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.section,
    height: 24 / AppFontSize.section,
    fontWeight: AppFontWeight.bold,
  );

  // Centered title in a screen header
  static TextStyle get navTitle => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.navTitle,
    height: 22 / AppFontSize.navTitle,
    fontWeight: AppFontWeight.bold,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.lg,
    height: 22 / AppFontSize.lg,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.button,
    height: 22 / AppFontSize.button,
    fontWeight: AppFontWeight.regular,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.md,
    height: 20 / AppFontSize.md,
    fontWeight: AppFontWeight.regular,
  );

  // Field labels, tile captions and hints
  static TextStyle get caption => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.caption,
    height: 18 / AppFontSize.caption,
    fontWeight: AppFontWeight.regular,
  );

  // Meta info such as dates
  static TextStyle get meta => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.sm,
    height: 16 / AppFontSize.sm,
    fontWeight: AppFontWeight.regular,
  );

  // Uppercase section label ("RECENTLY EDITED")
  static TextStyle get overline => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.sm,
    height: 16 / AppFontSize.sm,
    fontWeight: AppFontWeight.bold,
    letterSpacing: 0.96,
  );

  // Small badge text ("01")
  static TextStyle get badge => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.xs,
    fontWeight: AppFontWeight.bold,
  );

  static TextStyle get button => TextStyle(
    fontFamily: appFontFamily,
    fontSize: AppFontSize.button,
    fontWeight: AppFontWeight.bold,
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
    displaySmall: AppTextStyle.display.copyWith(color: textColor),
    headlineMedium: AppTextStyle.title.copyWith(color: textColor),
    headlineSmall: AppTextStyle.sheetTitle.copyWith(color: textColor),
    titleLarge: AppTextStyle.section.copyWith(color: textColor),
    titleMedium: AppTextStyle.navTitle.copyWith(color: textColor),
    bodyLarge: AppTextStyle.bodyLarge.copyWith(color: textColor),
    bodyMedium: AppTextStyle.bodySmall.copyWith(color: textColor),
    bodySmall: AppTextStyle.meta.copyWith(color: secondaryTextColor),
    labelLarge: AppTextStyle.button.copyWith(color: textColor),
  );
}
