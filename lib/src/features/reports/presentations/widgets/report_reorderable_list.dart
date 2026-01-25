import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/projects/domain/project_model.dart';

import '../../../projects/controller/pictolog_controller.dart';
import '../../domain/report_model.dart';
import '../report_item.dart';

class ReportReorderableList extends HookConsumerWidget {
  const ReportReorderableList({
    super.key,
    required this.pictolog,
    required this.isSelectionMode,
    required this.isReorderMode,
    required this.selectedKeys,
    required this.onLongPressSelection,
    required this.onTap,
  });

  final ProjectModel pictolog;
  final bool isSelectionMode;
  final bool isReorderMode;
  final Set<ReportModel> selectedKeys;
  final ValueChanged<ReportModel> onLongPressSelection;
  final ValueChanged<ReportModel>? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        buildDefaultDragHandles: isReorderMode,
        itemCount: pictolog.reports.length,
        padding: EdgeInsets.symmetric(
          horizontal: isReorderMode ? 16 : 10,
        ),
        onReorder: (oldIndex, newIndex) async {
          final onReorder = ref.read(pictologControllerProvider).onReorder;
          await onReorder(oldIndex, newIndex, pictolog);
        },
        itemBuilder: (context, index) {
          final report = pictolog.reports[index];
          final isSelected = selectedKeys.contains(report);

          return ReportItem(
            key: ValueKey(report),
            report: report,
            index: index,
            isSelected: isSelected,
            isSelectionMode: isSelectionMode,
            isReorderMode: isReorderMode,
            selectedKeys: selectedKeys,
            onLongPressSelection: onLongPressSelection,
            onTap: onTap,
          );
        },
      ),
    );
  }
}
