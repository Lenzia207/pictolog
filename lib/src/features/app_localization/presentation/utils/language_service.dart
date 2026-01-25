import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../widget/language_option.dart';

class LanguageService {
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return locale.languageCode;
    }
  }

  static String getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇬🇧';
      case 'de':
        return '🇩🇪';
      default:
        return '🌍';
    }
  }

  static void showLanguageDialog(
    BuildContext context,
    AppLocalizations appLanguage,
    List<Locale> supportedLocales,
    Locale currentLocale,
    ValueChanged<Locale> onLocaleChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.surface,
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
                languageName: getLanguageName(locale),
                languageFlag: getLanguageFlag(locale),
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
