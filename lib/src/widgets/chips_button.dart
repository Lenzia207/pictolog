import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/constants/app_text_style.dart';

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
      color: AppColor.surfaceLight,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColor.textSecondaryLight.withValues(alpha: 0.5),
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
                  color: AppColor.textPrimaryLight,
                ),
                const SizedBox(width: 8),
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
