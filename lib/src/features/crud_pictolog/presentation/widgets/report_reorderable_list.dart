import 'package:flutter/material.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';

import '../../controller/pictolog_controller.dart';
import '../../model/report.dart';
import '../ui/report_item.dart';

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
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: child,
          );
        },
        scrollDirection: Axis.horizontal,
        buildDefaultDragHandles: isReorderMode.value,
        itemCount: pictolog.reports.length,
        padding: EdgeInsets.symmetric(
          horizontal: isReorderMode.value ? 16 : 10,
        ),
        onReorder: (oldIndex, newIndex) =>
            PictologController().onReorder(oldIndex, newIndex, pictolog),
        itemBuilder: (context, index) {
          final report = pictolog.reports[index];
          final isSelected = selectedKeys.value.contains(report);

          return ReportItem(
            key: ValueKey(report),
            report: report,
            index: index,
            pictolog: pictolog,
            isSelected: isSelected,
            isSelectionMode: isSelectionMode,
            isReorderMode: isReorderMode,
            selectedKeys: selectedKeys,
          );
        },
      ),
    );
  }
}
