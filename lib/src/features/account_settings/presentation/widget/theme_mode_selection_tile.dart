import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';
import 'package:pictolog/src/constants/app_text_style.dart';
import 'package:pictolog/src/features/account_settings/provider/theme_provider.dart';

import '../../../../theme/theme.dart';

/// Theme mode selection tile widget
class ThemeModeSelectionTile extends ConsumerWidget {
  const ThemeModeSelectionTile({super.key});

  String _getThemeModeName(BuildContext context, ThemeMode mode) {
    final l10n = context.appLanguage;
    switch (mode) {
      case ThemeMode.light:
        return l10n.lightMode;
      case ThemeMode.dark:
        return l10n.darkMode;
      case ThemeMode.system:
        return l10n.systemMode;
    }
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final l10n = context.appLanguage;

    return ListTile(
      leading: Icon(
        Icons.palette_outlined,
        color: context.colors.primary,
      ),
      title: Text(
        l10n.theme,
        style: AppTextStyle.bodyLarge,
      ),
      subtitle: Text(
        _getThemeModeName(context, currentThemeMode),
        style: AppTextStyle.bodyMedium.copyWith(
          color: context.colors.primary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.colors.textSecondary,
      ),
      onTap: () => _showThemeModeDialog(context, ref, l10n),
    );
  }

  void _showThemeModeDialog(BuildContext context, WidgetRef ref, dynamic l10n) {
    final currentThemeMode = ref.read(themeModeProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            l10n.selectTheme,
            style: AppTextStyle.headlineSmall,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map((mode) {
              final isSelected = mode == currentThemeMode;
              return _ThemeModeOption(
                mode: mode,
                isSelected: isSelected,
                themeName: _getThemeModeName(context, mode),
                themeIcon: _getThemeModeIcon(mode),
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

/// Individual theme mode option in the selection dialog
class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({
    required this.mode,
    required this.isSelected,
    required this.themeName,
    required this.themeIcon,
    required this.onTap,
  });

  final ThemeMode mode;
  final bool isSelected;
  final String themeName;
  final IconData themeIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        themeIcon,
        color: isSelected ? context.colors.primary : null,
      ),
      title: Text(
        themeName,
        style: AppTextStyle.bodyLarge.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? context.colors.primary : null,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: context.colors.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
