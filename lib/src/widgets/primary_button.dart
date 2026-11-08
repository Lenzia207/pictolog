import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

enum PrimaryButtonVariant {
  /// Black pill — at most one per screen.
  primary,

  /// Muted pill for secondary actions.
  secondary,

  /// Red pill for destructive actions.
  danger,

  /// Text only, e.g. "Cancel".
  text,
}

/// Pill-shaped button, 52 px high.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = PrimaryButtonVariant.primary,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final PrimaryButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (backgroundColor, foregroundColor) = switch (variant) {
      PrimaryButtonVariant.primary => (colors.primary, colors.contrast),
      PrimaryButtonVariant.secondary => (
        colors.surfaceVariant,
        colors.textPrimary,
      ),
      PrimaryButtonVariant.danger => (colors.accentRed, AppColor.white),
      PrimaryButtonVariant.text => (Colors.transparent, colors.textPrimary),
    };

    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: variant == PrimaryButtonVariant.text
              ? Colors.transparent
              : colors.outlineStrong,
          disabledForegroundColor: colors.textSecondary,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: p24),
          textStyle: AppTextStyle.button,
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    Space.w8,
                  ],
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
