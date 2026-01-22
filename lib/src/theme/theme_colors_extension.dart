import 'package:flutter/material.dart';

import 'app_theme_colors.dart';

/// Extension to easily access theme colors from BuildContext.
extension AppThemeColorsExtension on BuildContext {
  AppThemeColors get colors =>
      Theme.of(this).extension<AppThemeColors>() ?? AppThemeColors.light;
}
