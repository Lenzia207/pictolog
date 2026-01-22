import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/features/crud_pictolog/model/report.dart';

import '../../../../l10n/localization_extension.dart';
import '../../camera/camera_screen.dart';
import '../../camera/service/app_camera_image_service.dart';
import '../model/pictolog.dart';
import '../presentation/ui/edit_report_dialog.dart';
import 'pictolog_repository.dart';

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  // For simplicity with synchronous access in ValueListenableBuilder, keeping the box open globally is preferred,
  // but here we can open it lazily if needed.
  return ReportRepository(
    Hive.box<Report>('reports'),
  );
});

class ReportRepository {
  ReportRepository(this.box);
  final Box<Report> box;

  static Future<bool?> saveReportDialog({
    required BuildContext context,
    required VoidCallback onImageChange,
    required TextEditingController descriptionController,
    required String imagePath,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => EditReportDialog(
        onImageChange: onImageChange,
        descriptionController: descriptionController,
        imagePath: imagePath,
        onSave: () => Navigator.pop(ctx, true),
      ),
    );
  }

  Future<void> addReport({
    required BuildContext context,
    required PictologRepository repository,
    required Pictolog pictolog,
    Report? report,
  }) async {
    try {
      // Show dialog to choose between camera or gallery
      final imageSource = await AppCameraImageService.showImageSourceDialog(
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
        final newReport = Report(
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
