import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';

import '../../constants/constants.dart';
import '../../theme/theme.dart';
import '../app_localization/app_localization.dart';
import 'widget/settings_section.dart';
import '../app_theme/widgets/theme_mode_selection_tile.dart';

/// Settings Screen with theme and language selection
class AccountSettingsScreen extends HookConsumerWidget {
  const AccountSettingsScreen({super.key});

  static const String path = "/account_settings";
  static const String name = "account_settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final appLanguage = context.appLanguage;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(p20, p12, p20, p24),
          children: [
            Text(
              appLanguage.settings,
              style: AppTextStyle.display.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            Space.h24,
            SettingsSection(
              label: appLanguage.appearance,
              child: const ThemeModeSelectionTile(),
            ),
            Space.h24,
            SettingsSection(
              label: appLanguage.general,
              child: LanguageSelectionTile(
                currentLocale: currentLocale,
                onLocaleChanged: (locale) {
                  ref.read(localeProvider.notifier).setLocale(locale);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
