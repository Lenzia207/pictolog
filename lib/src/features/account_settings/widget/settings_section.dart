import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

/// Settings section widget for grouping related settings
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: p4),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyle.overline.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
        Space.h8,
        Material(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ],
    );
  }
}

/// Square icon in front of a setting.
class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(
        icon,
        size: 18,
        color: context.colors.textPrimary,
      ),
    );
  }
}
