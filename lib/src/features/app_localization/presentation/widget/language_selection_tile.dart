import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';

import '../../../account_settings/widget/settings_section.dart';
import '../../app_localization.dart' as app_localization;
import '../utils/language_service.dart';

/// Language selection tile widget
class LanguageSelectionTile extends StatelessWidget {
  const LanguageSelectionTile({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: () => LanguageService.showLanguageSheet(
        context,
        app_localization.supportedLocales,
        currentLocale,
        onLocaleChanged,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: p16, vertical: p14),
          child: Row(
            children: [
              const SettingsIcon(icon: Icons.language),
              Space.w12,
              Expanded(
                child: Text(
                  context.appLanguage.language,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: AppFontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Text(
                LanguageService.getLanguageName(currentLocale),
                style: AppTextStyle.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              Space.w4,
              Icon(
                Icons.chevron_right,
                size: 18,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
