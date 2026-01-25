import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../domain/report_model.dart';
import '../../projects/presentation/widgets/pictolog_report_card.dart';
import 'widgets/selcetion_indicator.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({
    required super.key,
    required this.report,
    required this.index,
    required this.isSelected,
    required this.isSelectionMode,
    required this.isReorderMode,
    required this.selectedKeys,
    required this.onLongPressSelection,
    required this.onTap,
  });

  final ReportModel report;
  final int index;
  final bool isSelected;
  final bool isSelectionMode;
  final bool isReorderMode;
  final Set<ReportModel> selectedKeys;
  final ValueChanged<ReportModel> onLongPressSelection;
  final ValueChanged<ReportModel>? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: isReorderMode ? null : () => onLongPressSelection(report),
      onTap: isReorderMode ? null : () => onTap?.call(report),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Card
          Animate(
            effects: isReorderMode
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
              if (isReorderMode) {
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
          if (isSelectionMode)
            Positioned(
              top: 8,
              right: 28, // Adjust based on margin
              child: SelectionIndicator(isSelected: isSelected),
            ),

          // Reorder Overlay / Handle
          if (isReorderMode)
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
