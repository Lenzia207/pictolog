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
