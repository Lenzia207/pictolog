import 'package:flutter/material.dart';

import '../../../constants/app_text_style.dart';
import '../../../theme/theme.dart';

/// Individual language option in the selection dialog
class LanguageOption extends StatelessWidget {
  const LanguageOption({
    super.key,
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
