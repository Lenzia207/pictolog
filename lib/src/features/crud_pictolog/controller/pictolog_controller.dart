import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:pictolog/src/features/crud_pictolog/presentation/ui/edit_entry_dialog.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/ui/edit_report_dialog.dart';

import '../data/pictolog_repository.dart';
import '../data/report_repository.dart';
import '../model/pictolog.dart';
import '../model/report.dart';

final pictologControllerProvider = Provider((ref) => PictologController());

class PictologController {
  Future<void> showEditDialog(
    BuildContext context,
    WidgetRef ref,
    Pictolog pictolog,
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
              .read(pictologRepositoryProvider)
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
    Report report,
    Pictolog pictolog,
    ValueNotifier<int> rebuildToken,
  ) async {
    final descriptionController = TextEditingController(
      text: report.description,
    );
    final repository = ref.watch(pictologRepositoryProvider);
    String? newImagePath;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return EditReportDialog(
            onImageChange: () async {
              final report = ref.read(reportRepositoryProvider);

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

  Future<void> onReorder(int oldIndex, int newIndex, Pictolog pictolog) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = pictolog.reports.removeAt(oldIndex);
    pictolog.reports.insert(newIndex, item);
    await pictolog.save();
  }

  Future<void> rotateImage(
    Report report,
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
