import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../account_settings/widget/settings_section.dart';

/// Theme mode selection with a segmented control
class ThemeModeSelectionTile extends ConsumerWidget {
  const ThemeModeSelectionTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final appLanguage = context.appLanguage;
    final colors = context.colors;

    String themeModeName(ThemeMode mode) => switch (mode) {
      ThemeMode.light => appLanguage.lightMode,
      ThemeMode.dark => appLanguage.darkMode,
      ThemeMode.system => appLanguage.systemMode,
    };

    return Padding(
      padding: const EdgeInsets.all(p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const SettingsIcon(icon: Icons.contrast),
              Space.w12,
              Text(
                appLanguage.theme,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: AppFontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          Space.h14,
          Container(
            padding: const EdgeInsets.all(p4),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.input),
            ),
            child: Row(
              children: [
                for (final mode in [
                  ThemeMode.light,
                  ThemeMode.dark,
                  ThemeMode.system,
                ])
                  Expanded(
                    child: _Segment(
                      label: themeModeName(mode),
                      isSelected: mode == currentThemeMode,
                      onTap: () => ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(mode),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      selected: isSelected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: p2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? colors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColor.black.withValues(alpha: 0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(
              fontWeight: isSelected
                  ? AppFontWeight.bold
                  : AppFontWeight.regular,
              color: isSelected ? colors.textPrimary : colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
