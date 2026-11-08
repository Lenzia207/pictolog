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
  static const Color surfaceVariantDark = Color(0xFF2A2D30);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textBodyLight = Color(0xFF3A3E43);
  static const Color textBodyDark = Color(0xFFD6D6D6);
  // One step darker than #797E85 so small text stays readable on the background (4.7:1).
  static const Color textSecondaryLight = Color(0xFF686D74);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Image placeholder colors
  static const Color placeholderLight = Color(0xFFCFD5DA);
  static const Color placeholderMutedLight = Color(0xFFE3E7EA);
  static const Color placeholderDark = Color(0xFF3A3E42);
  static const Color placeholderMutedDark = Color(0xFF2A2D30);
  static const Color placeholderIcon = Color(0xFF8C9298);

  // Outline colors
  static const Color outlineLight = Color(0x0F000000);
  static const Color outlineDark = Color(0x0FFFFFFF);
  static const Color outlineStrongLight = Color(0xFFC4C8CC);
  static const Color outlineStrongDark = Color(0xFF4A4E52);

  // Accent color
  static const Color accentGreen = Color(0xFFC0E859);
  static const Color accentRed = Color(0xFFD04053);

  // Camera
  static const Color cameraPreview = Color(0xFF2A2C2E);

  // Prevent instantiation
  AppColor._();
}
