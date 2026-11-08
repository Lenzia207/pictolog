import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

/// Header of a sub screen: a leading button, a centered title and
/// an optional trailing widget.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final Widget leading;
  final String? title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(p12, p8, p12, 0),
      child: Row(
        children: [
          leading,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: AppTextStyle.navTitle.copyWith(
                      color: colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppTextStyle.meta.copyWith(
                      color: colors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          // Keeps the title centered when there is no trailing widget.
          trailing ?? const SizedBox(width: touchTarget),
        ],
      ),
    );
  }
}
