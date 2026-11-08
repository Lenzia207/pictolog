import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';

/// Shown in place of the pages grid while a Pictolog has no pages.
class EmptyEntriesMessage extends StatelessWidget {
  const EmptyEntriesMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: p20),
      padding: const EdgeInsets.symmetric(horizontal: p24, vertical: p30),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        children: [
          Icon(
            Icons.photo_camera_outlined,
            size: 28,
            color: colors.textSecondary,
          ),
          Space.h12,
          Text(
            context.appLanguage.noPagesYet,
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: AppFontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          Space.h4,
          Text(
            context.appLanguage.noPagesHint,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
