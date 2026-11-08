import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

enum AppTextFieldType {
  oneLiner,
  multiLines,
}

/// Text field with its label above it.
/// Thin outline at rest, 2 px primary outline on focus, red outline on error.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.type,
    this.hintText,
    this.trailingLabel,
    this.errorText,
    this.lines = 5,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final AppTextFieldType type;
  final String? hintText;

  /// Shown at the right of the label, e.g. "Optional".
  final String? trailingLabel;
  final String? errorText;

  /// Number of visible lines for [AppTextFieldType.multiLines].
  final int lines;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasError = errorText != null;

    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: BorderSide(color: color, width: width),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.caption.copyWith(
                  fontWeight: AppFontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
            ),
            if (trailingLabel != null)
              Text(
                trailingLabel!,
                style: AppTextStyle.meta.copyWith(
                  color: colors.textSecondary,
                ),
              ),
          ],
        ),
        Space.h8,
        TextField(
          controller: controller,
          autofocus: autofocus,
          onChanged: onChanged,
          minLines: type == AppTextFieldType.multiLines ? lines : 1,
          maxLines: type == AppTextFieldType.multiLines ? lines : 1,
          textCapitalization: TextCapitalization.sentences,
          style: AppTextStyle.bodyLarge.copyWith(color: colors.textPrimary),
          cursorColor: colors.primary,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.bodyLarge.copyWith(
              color: colors.textSecondary,
            ),
            filled: true,
            fillColor: colors.surface,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: p16,
              vertical: type == AppTextFieldType.multiLines ? p14 : 15,
            ),
            enabledBorder: hasError
                ? border(colors.accentRed, 2)
                : border(colors.outline, 1),
            focusedBorder: border(
              hasError ? colors.accentRed : colors.primary,
              2,
            ),
          ),
        ),
        if (hasError) ...[
          Space.h8,
          Text(
            errorText!,
            style: AppTextStyle.meta.copyWith(color: colors.accentRed),
          ),
        ],
      ],
    );
  }
}
