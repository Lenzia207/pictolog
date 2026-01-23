import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/constants.dart';
import '../../../../helper/helper.dart';
import '../../../../theme/theme.dart';
import '../../model/pictolog.dart';
import '../../model/report.dart';
import '../report/report_fullscreen_gallery.dart';
import '../widgets/pictolog_report_card.dart';
import '../widgets/selcetion_indicator.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({
    required super.key,
    required this.report,
    required this.index,
    required this.pictolog,
    required this.isSelected,
    required this.isSelectionMode,
    required this.isReorderMode,
    required this.selectedKeys,
  });

  final Report report;
  final int index;
  final Pictolog pictolog;
  final bool isSelected;
  final ValueNotifier<bool> isSelectionMode;
  final ValueNotifier<bool> isReorderMode;
  final ValueNotifier<Set<Report>> selectedKeys;

  @override
  Widget build(BuildContext context) {
    // Handle long press for selection mode
    void handleLongPress() {
      if (!isSelectionMode.value) {
        isSelectionMode.value = true;
      }
      Helper.toggleSelection(selectedKeys, report);
    }

    // Handle tap to either select or open report
    void handleTap(BuildContext context) {
      if (isSelectionMode.value) {
        Helper.toggleSelection(selectedKeys, report);
      } else {
        context.pushNamed(
          ReportFullscreenGallery.name,
          pathParameters: {
            'id': pictolog.key.toString(),
          },
          extra: {
            'pictolog': pictolog,
            'index': index,
          },
        );
      }
    }

    return GestureDetector(
      onLongPress: isReorderMode.value ? null : handleLongPress,
      onTap: isReorderMode.value ? null : () => handleTap(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Card
          Animate(
            effects: isReorderMode.value
                ? [
                    ShakeEffect(
                      duration: 1000.ms,
                      hz: 2,
                      rotation: 0.01,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [],
            onComplete: (controller) {
              if (isReorderMode.value) {
                controller.repeat(reverse: true);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: p20),
              width: p300,
              child: PictologReportCard(
                isSelectedItem: isSelected,
                report: report,
              ),
            ),
          ),

          // Selection Overlay
          if (isSelectionMode.value)
            Positioned(
              top: 8,
              right: 28, // Adjust based on margin
              child: SelectionIndicator(isSelected: isSelected),
            ),

          // Reorder Overlay / Handle
          if (isReorderMode.value)
            Center(
              child:
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colors.surface.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.drag_indicator,
                      color: context.colors.primary,
                      size: 20,
                    ),
                  ).animate().scale(
                    duration: 200.ms,
                    curve: Curves.easeOutBack,
                  ),
            ),
        ],
      ),
    );
  }
}
