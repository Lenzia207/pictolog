import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

/// Individual theme mode option in the selection dialog
class ThemeModeOption extends StatelessWidget {
  const ThemeModeOption({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.themeName,
    required this.themeIcon,
    required this.onTap,
  });

  final ThemeMode mode;
  final bool isSelected;
  final String themeName;
  final IconData themeIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        themeIcon,
        color: isSelected ? context.colors.primary : null,
      ),
      title: Text(
        themeName,
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
