import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/image_thumbnail.dart';
import '../../../reports/domain/report_model.dart';

/// Tile of a single page in the pages grid.
class PictologReportCard extends StatelessWidget {
  const PictologReportCard({
    super.key,
    required this.report,
    required this.index,
    required this.onTap,
  });

  static const double _imageHeight = 150;

  /// Image plus two lines of caption.
  static const double height = _imageHeight + p10 + 36 + p12;

  final ReportModel report;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasDescription = report.description?.isNotEmpty ?? false;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.tile),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ImageThumbnail(
                  imagePath: report.imagePath,
                  borderRadius: 0,
                  width: double.infinity,
                  height: _imageHeight,
                  iconSize: 24,
                ),
                Positioned(
                  top: p8,
                  left: p8,
                  child: Container(
                    height: 22,
                    padding: const EdgeInsets.symmetric(horizontal: p8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? colors.surface
                          : colors.background,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      (index + 1).toString().padLeft(2, '0'),
                      style: AppTextStyle.badge.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(p12, p10, p12, p12),
              child: Text(
                hasDescription
                    ? report.description!
                    : context.appLanguage.noDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.caption.copyWith(
                  color: hasDescription
                      ? colors.textPrimary
                      : colors.textSecondary,
                  fontStyle: hasDescription
                      ? FontStyle.normal
                      : FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
