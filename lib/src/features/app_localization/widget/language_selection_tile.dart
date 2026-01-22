import 'package:flutter/material.dart';

import '../../../../l10n/localization_extension.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

import '../app_localization.dart' as app_localization;
import '../service/language_service.dart';

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
    return ListTile(
      leading: Icon(
        Icons.language,
        color: context.colors.primary,
      ),
      title: Text(
        context.appLanguage.selectLanguage,
        style: AppTextStyle.bodyLarge,
      ),
      subtitle: Text(
        '${LanguageService.getLanguageFlag(currentLocale)} ${LanguageService.getLanguageName(currentLocale)}',
        style: AppTextStyle.bodyMedium.copyWith(
          color: context.colors.primary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.colors.surface.withAlpha(128),
      ),
      onTap: () => LanguageService.showLanguageDialog(
        context,
        context.appLanguage,
        app_localization.supportedLocales,
        currentLocale,
        onLocaleChanged,
      ),
    );
  }
}
