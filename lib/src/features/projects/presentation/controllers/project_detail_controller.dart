import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../reports/domain/report_model.dart';
import '../../../reports/presentations/report_fullscreen_gallery.dart';
import '../../../../helper/helper.dart';
import 'project_controller.dart';

/// Controller for managing project detail screen state and operations
class ProjectDetailController {
  final ProjectController repository;

  ProjectDetailController(this.repository);

  /// Deletes selected reports from a project
  Future<void> deleteSelectedReports({
    required Object pictologKey,
    required Set<ReportModel> selectedReports,
    required ValueNotifier<Set<ReportModel>> selectedKeys,
    required ValueNotifier<bool> isSelectionMode,
  }) async {
    final pictolog = repository.box.get(pictologKey);

    if (pictolog != null && selectedReports.isNotEmpty) {
      await repository.deleteReports(pictolog, selectedReports);
      selectedKeys.value = {};
      isSelectionMode.value = false;
    }
  }

  /// Handles long press on a report to enter/toggle selection mode
  void handleLongPress({
    required ReportModel report,
    required ValueNotifier<bool> isSelectionMode,
    required ValueNotifier<Set<ReportModel>> selectedKeys,
  }) {
    if (!isSelectionMode.value) {
      isSelectionMode.value = true;
    }
    selectedKeys.value = Helper.toggleSelection(selectedKeys.value, report);
  }

  /// Handles tap on a report - either selects it or opens fullscreen gallery
  void handleTap({
    required BuildContext context,
    required ReportModel report,
    required int index,
    required Object pictologKey,
    required ValueNotifier<bool> isSelectionMode,
    required ValueNotifier<Set<ReportModel>> selectedKeys,
  }) {
    if (isSelectionMode.value) {
      selectedKeys.value = Helper.toggleSelection(selectedKeys.value, report);
    } else {
      final pictolog = repository.box.get(pictologKey);
      if (pictolog != null) {
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
  }
}

/// Provider for ProjectDetailController
final projectDetailControllerProvider = Provider<ProjectDetailController>((
  ref,
) {
  final repository = ref.watch(projectRepositoryProvider);
  return ProjectDetailController(repository);
});
