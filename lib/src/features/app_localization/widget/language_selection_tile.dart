import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/localization_extension.dart';
import '../../../constants/app_style.dart';
import '../../../constants/app_text_style.dart';
import '../../../theme/theme.dart';
import '../../account_settings/provider/locale_provider.dart';
import 'language_option.dart';

/// Language selection tile widget
class LanguageSelectionTile extends StatelessWidget {
  const LanguageSelectionTile({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return locale.languageCode;
    }
  }

  String _getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇬🇧';
      case 'de':
        return '🇩🇪';
      default:
        return '🌍';
    }
  }

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
        '${_getLanguageFlag(currentLocale)} ${_getLanguageName(currentLocale)}',
        style: AppTextStyle.bodyMedium.copyWith(
          color: context.colors.primary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: context.colors.surface.withAlpha(128),
      ),
      onTap: () => _showLanguageDialog(context, context.appLanguage),
    );
  }

  void _showLanguageDialog(BuildContext context, AppLocalizations appLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            appLanguage.selectLanguage,
            style: AppTextStyle.headlineSmall,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: p16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: supportedLocales.map((locale) {
              final isSelected = locale == currentLocale;
              return LanguageOption(
                locale: locale,
                isSelected: isSelected,
                languageName: _getLanguageName(locale),
                languageFlag: _getLanguageFlag(locale),
                onTap: () {
                  onLocaleChanged(locale);
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
