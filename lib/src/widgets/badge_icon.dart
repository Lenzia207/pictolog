import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

class DateBadge extends StatelessWidget {
  const DateBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.colors,
  });

  final String label;
  final IconData icon;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: colors.textSecondary,
        ),
        Space.w6,
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
