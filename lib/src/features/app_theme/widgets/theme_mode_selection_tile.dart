import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../service/app_theme_service.dart';

/// Theme mode selection tile widget
class ThemeModeSelectionTile extends ConsumerWidget {
  const ThemeModeSelectionTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final appLanguage = context.appLanguage;

    return ListTile(
      leading: Icon(
        Icons.palette_outlined,
        color: context.colors.primary,
      ),
      title: Text(
        appLanguage.theme,
        style: AppTextStyle.bodyLarge,
      ),
      subtitle: Text(
        AppThemeService.getThemeModeName(context, currentThemeMode),
        style: AppTextStyle.bodyMedium.copyWith(
          color: context.colors.primary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.colors.textSecondary,
      ),
      onTap: () =>
          AppThemeService.showThemeModeDialog(context, ref, appLanguage),
    );
  }
}
