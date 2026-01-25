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
  });

  final ProjectModel pictolog;
  final ValueNotifier<bool> isSelectionMode;
  final ValueNotifier<bool> isReorderMode;
  final ValueNotifier<Set<ReportModel>> selectedKeys;

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
        buildDefaultDragHandles: isReorderMode.value,
        itemCount: pictolog.reports.length,
        padding: EdgeInsets.symmetric(
          horizontal: isReorderMode.value ? 16 : 10,
        ),
        onReorder: (oldIndex, newIndex) async {
          final onReorder = ref.read(pictologControllerProvider).onReorder;
          await onReorder(oldIndex, newIndex, pictolog);
        },
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
