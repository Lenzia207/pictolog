import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/theme.dart';

/// A small circled checkbox widget to indicate selection state.
class SelectionCheckbox extends StatelessWidget {
  const SelectionCheckbox({
    super.key,
    required this.isSelectedItem,
  });

  final bool isSelectedItem;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedContainer(
      duration: 200.ms,
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelectedItem ? colors.primary : Colors.transparent,
        border: isSelectedItem
            ? null
            : Border.all(color: colors.outlineStrong, width: 2),
      ),
      child: isSelectedItem
          ? Icon(
              Icons.check,
              size: 16,
              color: colors.accentGreen,
            ).animate().scale(
              duration: 200.ms,
              curve: Curves.easeOutBack,
            )
          : null,
    );
  }
}
