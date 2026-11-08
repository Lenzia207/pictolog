import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/selection_checkbox.dart';

/// Individual language option in the selection sheet
class LanguageOption extends StatelessWidget {
  const LanguageOption({
    super.key,
    required this.isSelected,
    required this.languageName,
    required this.onTap,
  });

  final bool isSelected;
  final String languageName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  languageName,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: isSelected
                        ? AppFontWeight.bold
                        : AppFontWeight.regular,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              SelectionCheckbox(isSelectedItem: isSelected),
              Space.w4,
            ],
          ),
        ),
      ),
    );
  }
}
