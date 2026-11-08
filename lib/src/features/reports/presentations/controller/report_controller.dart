import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../camera/presentation/camera_screen.dart';
import '../../../camera/presentation/utils/image_source_sheet.dart';
import '../../../projects/domain/project_model.dart';
import '../../../projects/presentation/controllers/project_controller.dart';
import '../../../projects/presentation/project_detail_screen.dart';

final reportControllerProvider = Provider<ReportController>((ref) {
  return ReportController(ref.watch(projectRepositoryProvider));
});

class ReportController {
  ReportController(this.repository);
  final ProjectController repository;

  /// Lets the user choose an image source and adds the new pages.
  Future<void> addPages({
    required BuildContext context,
    required ProjectModel pictolog,
  }) async {
    final imageSource = await showImageSourceSheet(context);
    if (imageSource == null || !context.mounted) return;

    try {
      if (imageSource == ImageSource.camera) {
        // The camera screen adds every captured photo as a page itself.
        await context.pushNamed(
          CameraScreen.name,
          pathParameters: {
            PictologDetailsScreen.paramId: pictolog.key.toString(),
          },
        );
        return;
      }

      final pickedFiles = await ImagePicker().pickMultiImage(
        imageQuality: 80,
      );
      await repository.addPages(
        pictolog,
        pickedFiles.map((file) => file.path).toList(),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.appLanguage.errorAddingPage(e.toString())),
          ),
        );
      }
    }
  }

  /// Lets the user take or choose a single image.
  /// Returns its temporary path, or null when cancelled.
  Future<String?> pickReplacementImage({
    required BuildContext context,
    required ProjectModel pictolog,
  }) async {
    final imageSource = await showImageSourceSheet(context);
    if (imageSource == null || !context.mounted) return null;

    if (imageSource == ImageSource.camera) {
      return context.pushNamed<String>(
        CameraScreen.name,
        pathParameters: {
          PictologDetailsScreen.paramId: pictolog.key.toString(),
        },
        extra: true,
      );
    }

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return pickedFile?.path;
  }

  /// Rotates the image file 90 degrees clockwise in place.
  Future<void> rotateImage(String imagePath) async {
    final imageFile = File(imagePath);
    if (!await imageFile.exists()) return;

    final image = img.decodeImage(await imageFile.readAsBytes());
    if (image == null) return;

    final rotatedImage = img.copyRotate(image, angle: 90);
    await imageFile.writeAsBytes(img.encodeJpg(rotatedImage));

    // The file path stays the same, so drop the cached (resized) versions.
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
