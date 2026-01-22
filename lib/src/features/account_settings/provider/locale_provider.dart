import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported locales for the application
const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('de'),
];

/// Provider for managing the app's locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// Notifier for managing locale state and persistence
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('de')) {
    // Load saved locale on initialization
    _loadLocale();
  }

  static const String _localeKey = 'app_locale';

  /// Load the saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey);

      if (localeCode != null) {
        final locale = Locale(localeCode);
        if (supportedLocales.contains(locale)) {
          state = locale;
        }
      }
    } catch (e) {
      // If loading fails, keep default locale
      debugPrint('Error loading locale: $e');
    }
  }

  /// Change the app's locale and persist the choice
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      return;
    }

    state = locale;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }
}
