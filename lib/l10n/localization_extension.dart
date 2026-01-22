import 'package:flutter/widgets.dart';
import 'app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get appLanguage {
    final localization = AppLocalizations.of(this);
    if (localization == null) {
      throw FlutterError(
        'AppLocalizations.of(context) returned null. '
        'Make sure MaterialApp has localizationsDelegates properly configured.',
      );
    }
    return localization;
  }
}
