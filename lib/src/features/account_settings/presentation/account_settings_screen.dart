import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/constants/app_style.dart';
import 'package:pictolog/src/constants/app_text_style.dart';
import 'package:pictolog/src/features/account_settings/provider/locale_provider.dart';

import '../../../../l10n/app_localizations.dart';

/// Account Settings Screen with language selection
class AccountSettingsScreen extends HookConsumerWidget {
  const AccountSettingsScreen({super.key});

  static const String path = "/account_settings";
  static const String name = "account_settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.appLanguage.accountSettings,
          style: AppTextStyle.headlineLarge,
        ),
        centerTitle: true,
        backgroundColor: context.colors.surface.withAlpha(0),
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(p16),
        children: [
          _SettingsSection(
            title: context.appLanguage.language,
            children: [
              _LanguageSelectionTile(
                currentLocale: currentLocale,
                onLocaleChanged: (locale) {
                  ref.read(localeProvider.notifier).setLocale(locale);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Settings section widget for grouping related settings
class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: p8,
            vertical: p12,
          ),
          child: Text(
            title,
            style: AppTextStyle.titleLarge.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          color: context.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
        Space.h20,
      ],
    );
  }
}

/// Language selection tile widget
class _LanguageSelectionTile extends StatelessWidget {
  const _LanguageSelectionTile({
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
              return _LanguageOption(
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

/// Individual language option in the selection dialog
class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.locale,
    required this.isSelected,
    required this.languageName,
    required this.languageFlag,
    required this.onTap,
  });

  final Locale locale;
  final bool isSelected;
  final String languageName;
  final String languageFlag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        languageFlag,
        style: const TextStyle(fontSize: 32),
      ),
      title: Text(
        languageName,
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
