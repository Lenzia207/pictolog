import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/sheet_handle.dart';
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

  static void showLanguageSheet(
    BuildContext context,
    List<Locale> supportedLocales,
    Locale currentLocale,
    ValueChanged<Locale> onLocaleChanged,
  ) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(p20, 0, p20, p8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SheetHandle(),
                Space.h18,
                Text(
                  context.appLanguage.selectLanguage,
                  style: AppTextStyle.sheetTitle.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                Space.h12,
                ...supportedLocales.map((locale) {
                  return LanguageOption(
                    isSelected: locale == currentLocale,
                    languageName: getLanguageName(locale),
                    onTap: () {
                      onLocaleChanged(locale);
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
