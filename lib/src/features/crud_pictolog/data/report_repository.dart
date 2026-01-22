import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/features/crud_pictolog/model/report.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../model/pictolog.dart';
import '../../camera/camera_screen.dart';
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

  Future<void> addReport({
    required BuildContext context,
    required PictologRepository repository,
    required Pictolog pictolog,
  }) async {
    try {
      // Show dialog to choose between camera or gallery
      final imageSource = await _showImageSourceDialog(context);
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

      // Show dialog for description
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(context.appLanguage.addDescription),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
              Space.h12,
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: context.appLanguage.description,
                  hintText: context.appLanguage.generalProjectDescription,
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.appLanguage.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(context.appLanguage.save),
            ),
          ],
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

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.appLanguage.chooseImageSource),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.appLanguage.camera),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.appLanguage.gallery),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
