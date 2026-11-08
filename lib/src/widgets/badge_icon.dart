import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

/// Rounded chip showing a date with a leading icon.
class DateBadge extends StatelessWidget {
  const DateBadge({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: p10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
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
            style: AppTextStyle.meta.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
