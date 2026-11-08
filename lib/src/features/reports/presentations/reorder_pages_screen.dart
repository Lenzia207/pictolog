import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/image_thumbnail.dart';
import '../../projects/presentation/controllers/project_controller.dart';
import '../../projects/presentation/widgets/pictolog_builder.dart';
import '../domain/report_model.dart';

/// Lets the user drag pages into a new order.
class ReorderPagesScreen extends ConsumerWidget {
  const ReorderPagesScreen({
    super.key,
    required this.pictologKey,
  });

  static const String path = 'reorder';
  static const String name = 'ReorderPages';

  final int pictologKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;

    return PictologBuilder(
      pictologKey: pictologKey,
      builder: (context, pictolog) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(p20, p8, p16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appLanguage.changeOrder,
                        style: AppTextStyle.navTitle.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: FilledButton(
                        onPressed: () => context.pop(),
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.contrast,
                          padding: const EdgeInsets.symmetric(horizontal: p18),
                          textStyle: AppTextStyle.bodySmall.copyWith(
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        child: Text(appLanguage.done),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(p20, p12, p20, p18),
                child: Text(
                  appLanguage.reorderHint,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  padding: const EdgeInsets.fromLTRB(p20, 0, p20, p20),
                  buildDefaultDragHandles: false,
                  itemCount: pictolog.reports.length,
                  proxyDecorator: (child, index, animation) => Material(
                    color: Colors.transparent,
                    child: Transform.rotate(
                      angle: -0.026,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.tile),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withValues(alpha: 0.16),
                              blurRadius: 32,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.tile),
                          border: Border.all(
                            color: colors.accentGreen,
                            width: 2,
                          ),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                  onReorder: (oldIndex, newIndex) => ref
                      .read(projectRepositoryProvider)
                      .reorderPages(pictolog, oldIndex, newIndex),
                  itemBuilder: (context, index) {
                    final report = pictolog.reports[index];
                    return Padding(
                      key: ObjectKey(report),
                      padding: const EdgeInsets.only(bottom: p8),
                      child: _ReorderRow(report: report, index: index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReorderRow extends StatelessWidget {
  const _ReorderRow({
    required this.report,
    required this.index,
  });

  final ReportModel report;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasDescription = report.description?.isNotEmpty ?? false;

    return Container(
      padding: const EdgeInsets.fromLTRB(p10, p10, p6, p10),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: AppTextStyle.caption.copyWith(
                fontWeight: AppFontWeight.bold,
                color: colors.textSecondary,
              ),
            ),
          ),
          Space.w12,
          ImageThumbnail(
            imagePath: report.imagePath,
            borderRadius: AppRadius.sm,
            width: 52,
            height: 52,
          ),
          Space.w12,
          Expanded(
            child: Text(
              hasDescription
                  ? report.description!
                  : context.appLanguage.noDescription,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bodySmall.copyWith(
                color: hasDescription
                    ? colors.textPrimary
                    : colors.textSecondary,
                fontStyle: hasDescription ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ),
          ReorderableDragStartListener(
            index: index,
            child: SizedBox.square(
              dimension: touchTarget,
              child: Icon(
                Icons.drag_indicator,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
