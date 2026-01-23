import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../theme/theme.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({
    super.key,
    required this.isSelected,
  });
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedContainer(
      duration: 200.ms,
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? colors.primary
            : colors.surface.withValues(alpha: 0.9),
        border: Border.all(
          color: isSelected
              ? colors.primary
              : colors.textSecondary.withValues(alpha: .3),
          width: 2,
        ),
        boxShadow: [
          if (!isSelected)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
            ),
        ],
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              size: 16,
              color: colors.background,
            ).animate().scale(
              duration: 400.ms,
              curve: Curves.easeOutBack,
            )
          : null,
    );
  }
}
