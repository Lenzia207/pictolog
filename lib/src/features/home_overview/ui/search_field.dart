import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: BorderSide(color: colors.outline),
    );

    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: AppTextStyle.bodyMedium.copyWith(color: colors.textPrimary),
        cursorColor: colors.primary,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.bodyMedium.copyWith(
            color: colors.textSecondary,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: colors.textSecondary,
          ),
          filled: true,
          fillColor: colors.surface,
          contentPadding: EdgeInsets.zero,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
