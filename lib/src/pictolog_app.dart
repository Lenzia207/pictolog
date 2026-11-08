import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/router/app_router.dart';

import '../l10n/app_localizations.dart';
import 'constants/constants.dart';
import 'features/app_localization/app_localization.dart';
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
      theme: _buildTheme(Brightness.light, AppThemeColors.light),
      darkTheme: _buildTheme(Brightness.dark, AppThemeColors.dark),
    );
  }

  ThemeData _buildTheme(Brightness brightness, AppThemeColors colors) {
    return ThemeData(
      brightness: brightness,
      fontFamily: appFontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.contrast,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        error: colors.accentRed,
      ),
      textTheme: createTextTheme(
        textColor: colors.textPrimary,
        secondaryTextColor: colors.textSecondary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionHandleColor: colors.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.primary,
        contentTextStyle: AppTextStyle.bodySmall.copyWith(
          color: colors.contrast,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.emptyCard),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),
      extensions: [
        colors,
      ],
    );
  }
}
