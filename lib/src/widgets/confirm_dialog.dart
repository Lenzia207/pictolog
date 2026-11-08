import 'package:flutter/material.dart';

import '../../l10n/localization_extension.dart';
import '../constants/constants.dart';
import '../theme/theme.dart';
import 'primary_button.dart';

/// Asks the user to confirm a destructive action.
/// Resolves to true when confirmed.
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: AppTextStyle.sheetTitle.copyWith(
          color: context.colors.textPrimary,
        ),
      ),
      content: Text(
        message,
        style: AppTextStyle.bodyMedium.copyWith(
          color: context.colors.textBody,
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(p16, 0, p16, p16),
      actions: [
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: context.appLanguage.cancel,
                variant: PrimaryButtonVariant.text,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            Space.w8,
            Expanded(
              child: PrimaryButton(
                label: confirmLabel,
                variant: PrimaryButtonVariant.danger,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
