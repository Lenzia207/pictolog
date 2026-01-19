import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/constants/app_style.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/widgets/pictolog_report_card.dart';

import '../../../../helper/helper.dart';
import '../../model/report.dart';
import '../report/report_fullscreen_gallery.dart';

class ReportReorderableList extends StatelessWidget {
  const ReportReorderableList({
    super.key,
    required this.pictolog,
    required this.isSelectionMode,
    required this.isReorderMode,
    required this.selectedKeys,
  });
  final Pictolog pictolog;
  final ValueNotifier<bool> isSelectionMode;
  final ValueNotifier<bool> isReorderMode;
  final ValueNotifier<Set<Report>> selectedKeys;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,

      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        buildDefaultDragHandles: isReorderMode.value,
        itemCount: pictolog.reports.length,
        padding: EdgeInsets.symmetric(
          horizontal: isReorderMode.value ? 16 : 10,
        ),
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = pictolog.reports.removeAt(oldIndex);
          pictolog.reports.insert(newIndex, item);
          await pictolog.save();
        },
        itemBuilder: (context, index) {
          final reports = pictolog.reports;
          final report = reports[index];

          final isSelected = selectedKeys.value.contains(
            report,
          );

          return GestureDetector(
            key: ValueKey(report),
            onLongPress: isReorderMode.value
                ? null
                : () {
                    if (!isSelectionMode.value) {
                      isSelectionMode.value = true;
                    }
                    Helper.toggleSelection(selectedKeys, report);
                  },
            onTap: isReorderMode.value
                ? null
                : () {
                    if (isSelectionMode.value) {
                      Helper.toggleSelection(
                        selectedKeys,
                        report,
                      );
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
                  },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(
                    right: p20,
                  ), // Spacing between items
                  child: PictologReportCard(
                    isSelectedItem: isSelected,
                    isSelectionMode: isSelectionMode.value,
                    report: report,
                  ),
                ),
                if (isReorderMode.value)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.drag_indicator,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
