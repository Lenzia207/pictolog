import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:pictolog/src/features/projects/presentation/widgets/edit_entry_dialog.dart';
import 'package:pictolog/src/features/reports/presentations/edit_report_dialog.dart';

import '../presentation/controllers/project_controller.dart';
import '../../reports/presentations/controller/report_controller.dart';
import '../domain/project_model.dart';
import '../../reports/domain/report_model.dart';

final pictologControllerProvider = Provider((ref) => PictologController());

class PictologController {
  Future<void> showEditDialog(
    BuildContext context,
    WidgetRef ref,
    ProjectModel pictolog,
  ) async {
    final nameController = TextEditingController(
      text: pictolog.name,
    );
    final descriptionController = TextEditingController(
      text: pictolog.overviewDescription,
    );

    await showDialog(
      context: context,
      builder: (context) => EditEntryDialog(
        nameController: nameController,
        descriptionController: descriptionController,
        onSave: () {
          ref
              .read(projectRepositoryProvider)
              .updatePictolog(
                pictolog,
                name: nameController.text.trim(),
                overviewDescription: descriptionController.text.trim(),
              );
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> showEditPageDialog(
    BuildContext context,
    WidgetRef ref,
    ReportModel report,
    ProjectModel pictolog,
    ValueNotifier<int> rebuildToken,
  ) async {
    final descriptionController = TextEditingController(
      text: report.description,
    );
    final repository = ref.watch(projectRepositoryProvider);
    String? newImagePath;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return EditReportDialog(
            onImageChange: () async {
              final report = ref.read(reportControllerProvider);

              report.addReport(
                context: context,
                repository: repository,
                pictolog: pictolog,
              );
            },
            imagePath: newImagePath ?? report.imagePath,
            descriptionController: descriptionController,
            onRotate: () async {
              await rotateImage(report, rebuildToken);
              setState(() {});
            },
            onSave: () async {
              // Update Description
              report.description = descriptionController.text.trim();

              // Save Changes
              await pictolog.save();

              // Trigger UI Rebuild
              rebuildToken.value++;

              if (context.mounted) {
                context.pop();
              }
            },
          );
        },
      ),
    );
  }

  Future<void> onReorder(
    int oldIndex,
    int newIndex,
    ProjectModel pictolog,
  ) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = pictolog.reports.removeAt(oldIndex);
    pictolog.reports.insert(newIndex, item);
    await pictolog.save();
  }

  Future<void> rotateImage(
    ReportModel report,
    ValueNotifier<int> rebuildToken,
  ) async {
    final imageFile = File(report.imagePath);
    if (!await imageFile.exists()) return;

    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return;

    // Rotate 90 degrees clockwise
    final rotatedImage = img.copyRotate(image, angle: 90);

    // Encode as JPG (preserving quality as much as possible, here using default)
    final encodedBytes = img.encodeJpg(rotatedImage);

    await imageFile.writeAsBytes(encodedBytes);

    // Evict from cache
    // We clear the whole cache to be safe as sometimes keys can vary
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    // Trigger UI Rebuild
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    rebuildToken.notifyListeners();
    // Or just value++ if it's ValueNotifier<int>
    rebuildToken.value++;
  }
}
