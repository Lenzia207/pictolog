import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_style.dart';
import '../../../../helper/helper.dart';
import '../../../../theme/theme.dart';
import '../../model/pictolog.dart';
import '../../model/report.dart';
import '../report/report_fullscreen_gallery.dart';
import '../widgets/pictolog_report_card.dart';

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
          Container(
            width: p300,
            margin: const EdgeInsets.only(right: p20),
            child: PictologReportCard(
              isSelectedItem: isSelected,
              isSelectionMode: isSelectionMode.value,
              report: report,
            ),
          ),
          if (isReorderMode.value)
            Container(
              decoration: BoxDecoration(
                color: context.colors.accentGreen,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.drag_indicator,
                color: Colors.black,
                size: 32,
              ),
            ),
        ],
      ),
    );
  }
}
