import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../widgets/theme_options.dart';

class AppThemeService {
  const AppThemeService();

  static String getThemeModeName(
    BuildContext context,
    ThemeMode mode,
  ) {
    final appLanguage = context.appLanguage;
    switch (mode) {
      case ThemeMode.light:
        return appLanguage.lightMode;
      case ThemeMode.dark:
        return appLanguage.darkMode;
      case ThemeMode.system:
        return appLanguage.systemMode;
    }
  }

  static IconData getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  static void showThemeModeDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations appLanguage,
  ) {
    final currentThemeMode = ref.read(themeModeProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.surface,
          title: Text(
            appLanguage.selectTheme,
            style: AppTextStyle.headlineSmall,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map((mode) {
              final isSelected = mode == currentThemeMode;
              return ThemeModeOption(
                mode: mode,
                isSelected: isSelected,
                themeName: getThemeModeName(context, mode),
                themeIcon: getThemeModeIcon(mode),
                onTap: () {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
