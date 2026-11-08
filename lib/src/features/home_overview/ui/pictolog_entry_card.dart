import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/image_thumbnail.dart';
import '../../projects/domain/project_model.dart';

class PictologEntryCard extends StatelessWidget {
  const PictologEntryCard({
    super.key,
    required this.pictolog,
    required this.onTapItem,
    required this.onLongPressed,
  });

  final ProjectModel pictolog;
  final VoidCallback onTapItem;
  final VoidCallback onLongPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
            side: BorderSide(color: colors.outline),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTapItem,
            onLongPress: onLongPressed,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(p12, p12, p14, p12),
              child: Row(
                children: [
                  StackedThumbnail(
                    imagePath: pictolog.reports.firstOrNull?.imagePath,
                  ),
                  Space.w14,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pictolog.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyLarge.copyWith(
                            fontWeight: AppFontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        if (pictolog.overviewDescription.isNotEmpty) ...[
                          Space.h3,
                          Text(
                            pictolog.overviewDescription,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                        Space.h6,
                        Row(
                          children: [
                            PageCountChip(count: pictolog.reports.length),
                            Space.w8,
                            Text(
                              pictolog.lastEditedAt.toFormatDMY,
                              style: AppTextStyle.meta.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(
          begin: 0.1,
          duration: 300.ms,
          curve: Curves.easeOutQuad,
        );
  }
}

/// Cover image of a Pictolog with a second card peeking out behind it.
class StackedThumbnail extends StatelessWidget {
  const StackedThumbnail({
    super.key,
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 64,
      child: Stack(
        children: [
          Positioned.fill(
            left: p6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.placeholderMuted,
                borderRadius: BorderRadius.circular(AppRadius.thumbnail),
              ),
            ),
          ),
          Positioned.fill(
            top: p4,
            right: p6,
            child: ImageThumbnail(
              imagePath: imagePath,
              borderRadius: AppRadius.thumbnail,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small chip like "12 pages".
class PageCountChip extends StatelessWidget {
  const PageCountChip({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: p8, vertical: p3),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(p8),
      ),
      child: Text(
        context.appLanguage.pagesCount(count),
        style: AppTextStyle.meta.copyWith(
          fontWeight: AppFontWeight.bold,
          color: context.colors.textPrimary,
        ),
      ),
    );
  }
}
