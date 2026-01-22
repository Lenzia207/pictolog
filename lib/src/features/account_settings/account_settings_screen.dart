import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';

import '../../constants/constants.dart';
import '../../theme/theme.dart';
import '../app_localization/app_localization.dart';
import 'widget/settings_section.dart';
import '../app_theme/widgets/theme_mode_selection_tile.dart';

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
          SettingsSection(
            children: [
              LanguageSelectionTile(
                currentLocale: currentLocale,
                onLocaleChanged: (locale) {
                  ref.read(localeProvider.notifier).setLocale(locale);
                },
              ),
              const Divider(height: 1),
              const ThemeModeSelectionTile(),
            ],
          ),
        ],
      ),
    );
  }
}
