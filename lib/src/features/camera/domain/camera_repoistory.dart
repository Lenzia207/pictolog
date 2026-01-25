import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraService {
  static Future<void> takePicture({
    required BuildContext context,
    required CameraController? controller,
    required ValueNotifier<bool> isInitialized,
    required ValueNotifier<bool> isTakingPicture,
  }) async {
    if (controller == null ||
        !controller.value.isInitialized ||
        isTakingPicture.value) {
      return;
    }

    isTakingPicture.value = true;

    try {
      final image = await controller.takePicture();

      // Crop image to 4:3 aspect ratio programmatically
      final originalImage = img.decodeImage(
        File(image.path).readAsBytesSync(),
      );
      if (originalImage == null) {
        throw Exception('Failed to decode image');
      }

      // Calculate 4:3 crop dimensions (portrait mode: width/height = 3/4)
      final targetAspectRatio = 3 / 4;
      final currentAspectRatio = originalImage.width / originalImage.height;

      int cropWidth = originalImage.width;
      int cropHeight = originalImage.height;
      int cropX = 0;
      int cropY = 0;

      if (currentAspectRatio > targetAspectRatio) {
        // Image is wider than 3:4, crop width
        cropWidth = (originalImage.height * targetAspectRatio).round();
        cropX = ((originalImage.width - cropWidth) / 2).round();
      } else {
        // Image is taller than 3:4, crop height
        cropHeight = (originalImage.width / targetAspectRatio).round();
        cropY = ((originalImage.height - cropHeight) / 2).round();
      }

      final croppedImage = img.copyCrop(
        originalImage,
        x: cropX,
        y: cropY,
        width: cropWidth,
        height: cropHeight,
      );

      // Save cropped image
      final directory = await getTemporaryDirectory();
      final croppedPath =
          '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
      File(croppedPath).writeAsBytesSync(
        img.encodeJpg(croppedImage, quality: 85),
      );

      // Delete original uncropped image
      File(image.path).deleteSync();

      if (context.mounted) {
        context.pop(croppedPath);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking picture: $e')),
        );
      }
    } finally {
      isTakingPicture.value = false;
    }
  }
}
