import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/constants/app_text_style.dart';
import 'package:pictolog/src/features/account_settings/provider/locale_provider.dart';
import 'package:pictolog/src/features/account_settings/provider/theme_provider.dart';
import 'package:pictolog/src/router/app_router.dart';

import '../l10n/app_localizations.dart';
import 'theme/theme.dart';

class PictologApp extends HookConsumerWidget {
  const PictologApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final currentLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      locale: currentLocale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations
            .delegate, // Provides default localizations for Material widgets
        GlobalWidgetsLocalizations
            .delegate, // Provides default localizations for general widgets
        GlobalCupertinoLocalizations
            .delegate, // Provides default localizations for Cupertino widgets (iOS style)
      ],
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppThemeColors.light.background,
        textTheme: createTextTheme(
          textColor: AppThemeColors.light.textPrimary,
          secondaryTextColor: AppThemeColors.light.textSecondary,
        ),
        extensions: const [
          AppThemeColors.light,
        ],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppThemeColors.dark.background,
        textTheme: createTextTheme(
          textColor: AppThemeColors.dark.textPrimary,
          secondaryTextColor: AppThemeColors.dark.textSecondary,
        ),
        extensions: const [
          AppThemeColors.dark,
        ],
      ),
    );
  }
}
