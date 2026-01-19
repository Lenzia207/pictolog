import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/ui/edit_entry_dialog.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/ui/edit_report_dialog.dart';

import '../data/pictolog_repository.dart';
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
    String? newImagePath;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return EditReportDialog(
            onImageChange: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                setState(() {
                  newImagePath = pickedFile.path;
                });
              }
            },
            imagePath: newImagePath ?? report.imagePath,
            descriptionController: descriptionController,
            onSave: () async {
              // Update Description
              report.description = descriptionController.text.trim();

              // Update Image if changed
              if (newImagePath != null) {
                final savedPath = await ref
                    .read(pictologRepositoryProvider)
                    .saveImageToAppStorage(File(newImagePath!));
                report.imagePath = savedPath;
              }

              // Save Changes
              await pictolog.save();

              // Trigger UI Rebuild
              rebuildToken.value++;

              if (context.mounted) {
                Navigator.of(context).pop();
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
}
