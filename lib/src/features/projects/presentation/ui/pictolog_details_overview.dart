import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../../../l10n/localization_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/badge_icon.dart';
import '../../domain/project_model.dart';

/// Title, description and dates of a Pictolog followed by the pages header.
class PictologDetailsOverview extends StatelessWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
    required this.onSortPressed,
  });

  final ProjectModel pictolog;

  /// Null while there is nothing to sort.
  final VoidCallback? onSortPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;

    return Padding(
      padding: const EdgeInsets.fromLTRB(p20, p8, p20, p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pictolog.name,
            style: AppTextStyle.title.copyWith(color: colors.textPrimary),
          ).animate().fadeIn(duration: 300.ms),
          if (pictolog.overviewDescription.isNotEmpty) ...[
            Space.h10,
            Text(
              pictolog.overviewDescription,
              style: AppTextStyle.bodyMedium.copyWith(color: colors.textBody),
            ),
          ],
          Space.h14,
          Wrap(
            spacing: p8,
            runSpacing: p8,
            children: [
              DateBadge(
                label: appLanguage.createdOn(pictolog.createdAt.toFormatDMY),
                icon: Icons.calendar_today_outlined,
              ),
              if (pictolog.updatedAt != null)
                DateBadge(
                  label: appLanguage.editedOn(pictolog.updatedAt!.toFormatDMY),
                  icon: Icons.edit_outlined,
                ),
            ],
          ),
          Space.h24,

          // Pages header with sort action
          Row(
            children: [
              Text(
                appLanguage.pages,
                style: AppTextStyle.section.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Space.w8,
              Container(
                constraints: const BoxConstraints(minWidth: 24),
                height: 22,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  '${pictolog.reports.length}',
                  style: AppTextStyle.meta.copyWith(color: colors.contrast),
                ),
              ),
              const Spacer(),
              if (onSortPressed != null)
                Material(
                  color: colors.surface,
                  shape: const StadiumBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onSortPressed,
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: p12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swap_vert,
                            size: 16,
                            color: colors.textPrimary,
                          ),
                          Space.w6,
                          Text(
                            appLanguage.sort,
                            style: AppTextStyle.caption.copyWith(
                              fontWeight: AppFontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
