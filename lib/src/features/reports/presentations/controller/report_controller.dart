import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/features/reports/domain/report_model.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../camera/presentation/camera_screen.dart';
import '../../../camera/presentation/controller/camera_controller.dart';
import '../../../projects/domain/project_model.dart';
import '../edit_report_dialog.dart';
import '../../../projects/presentation/controllers/project_controller.dart';

final reportControllerProvider = Provider<ReportController>((ref) {
  // For simplicity with synchronous access in ValueListenableBuilder, keeping the box open globally is preferred,
  // but here we can open it lazily if needed.
  return ReportController(
    Hive.box<ReportModel>('reports'),
  );
});

class ReportController {
  ReportController(this.box);
  final Box<ReportModel> box;

  static Future<bool?> saveReportDialog({
    required BuildContext context,
    required VoidCallback onImageChange,
    required TextEditingController descriptionController,
    required String imagePath,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return EditReportDialog(
            onImageChange: onImageChange,
            descriptionController: descriptionController,
            imagePath: imagePath,

            onSave: () => Navigator.pop(ctx, true),
          );
        },
      ),
    );
  }

  Future<void> addReport({
    required BuildContext context,
    required ProjectController repository,
    required ProjectModel pictolog,
    ReportModel? report,
  }) async {
    try {
      // Show dialog to choose between camera or gallery
      final imageSource = await CameraController.showImageSourceDialog(
        context,
      );
      if (imageSource == null) return;

      String? imagePath;

      if (imageSource == ImageSource.camera) {
        // Use camera package directly with 4:3 aspect ratio (auto-cropped)
        if (!context.mounted) return;
        imagePath = await context.pushNamed<String>(
          CameraScreen.name,
          pathParameters: {
            'id': pictolog.key.toString(),
          },
        );
      } else {
        // Use image picker for gallery
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );

        if (pickedFile != null) {
          imagePath = pickedFile.path;
        }
      }

      if (imagePath == null) return;

      final descriptionController = TextEditingController();

      if (!context.mounted) return;

      // Show dialog to apply description if needed
      final shouldSave = await saveReportDialog(
        context: context,
        imagePath: imagePath,
        descriptionController: descriptionController,
        onImageChange: () => addReport(
          context: context,
          repository: repository,
          pictolog: pictolog,
        ),
      );

      if (shouldSave == true) {
        final permanentPath = await repository.saveImageToAppStorage(
          File(imagePath),
        );
        final newReport = ReportModel(
          imagePath: permanentPath,
          description: descriptionController.text,
        );

        pictolog.reports.add(newReport);
        await pictolog.save(); // HiveObject save
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              context.appLanguage.errorAddingReport(
                e.toString(),
              ),
            ),
          ),
        );
      }
    }
  }
}
