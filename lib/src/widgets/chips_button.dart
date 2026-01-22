import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_text_style.dart';

import '../constants/app_style.dart';
import '../theme/theme.dart';

class ChipsButton extends StatelessWidget {
  const ChipsButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(p20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(p20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: p16,
            vertical: p8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.colors.primary.withValues(
                alpha: 0.5,
              ),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: context.colors.primary,
                ),
                Space.w8,
              ],
              Text(
                label,
                style: AppTextStyle.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
