/// Extension on [DateTime] to provide easy formatting access.
/// This avoids the need for a helper class or context if not strictly necessary,
/// and works with both Flutter widgets and PDF widgets.
extension AppDateFormat on DateTime {
  /// Returns the date formatted as "dd.MM.yyyy" (German format).
  String get toFormatDMY {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
  }
}
