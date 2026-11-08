import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

/// Bar pinned to the bottom of a screen holding its main actions.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.child,
    this.showBorder = true,
  });

  final Widget child;

  /// When false the bar blends into the screen background.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: showBorder ? colors.surface : colors.background,
        border: showBorder
            ? Border(top: BorderSide(color: colors.outline))
            : null,
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: p16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(p20, p14, p20, 0),
          child: child,
        ),
      ),
    );
  }
}
