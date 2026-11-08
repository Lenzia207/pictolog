import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';

/// Widget: Representing a single tab item in the bottom navigation bar.
class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isSelected = index == currentIndex;

    return Semantics(
      selected: isSelected,
      button: true,
      child: InkResponse(
        onTap: () => onTap(index),
        radius: 40,
        child: SizedBox(
          width: 112,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: 200.ms,
                width: 56,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isSelected ? colors.contrast : colors.textSecondary,
                ),
              ),
              Space.h4,
              Text(
                label,
                style: AppTextStyle.meta.copyWith(
                  color: isSelected ? colors.textPrimary : colors.textSecondary,
                  fontWeight: isSelected
                      ? AppFontWeight.bold
                      : AppFontWeight.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
