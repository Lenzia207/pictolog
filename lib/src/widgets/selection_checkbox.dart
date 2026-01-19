import 'package:flutter/material.dart';

import '../constants/app_color.dart';

/// A small circled checkbox widget to indicate selection state.
class SelectionCheckbox extends StatelessWidget {
  const SelectionCheckbox({
    super.key,
    required this.isSelectedItem,
  });

  final bool isSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelectedItem
              ? context.colors.accentRed
              : context.colors.surface,
        ),
        child: isSelectedItem
            ? Icon(
                Icons.check_circle,
                color: context.colors.surface,
              )
            : Icon(
                Icons.radio_button_unchecked,
                color: context.colors.primary,
              ),
      ),
    );
  }
}
