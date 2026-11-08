import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraService {
  /// Portrait 3:4, the same ratio as the camera preview.
  static const double targetAspectRatio = 3 / 4;

  /// Takes a picture, crops it to [targetAspectRatio] and
  /// returns the path of the cropped temporary file.
  static Future<String> takePicture(CameraController controller) async {
    final image = await controller.takePicture();

    final originalImage = img.decodeImage(
      await File(image.path).readAsBytes(),
    );
    if (originalImage == null) {
      throw Exception('Failed to decode image');
    }

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

    final directory = await getTemporaryDirectory();
    final croppedPath =
        '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(croppedPath).writeAsBytes(
      img.encodeJpg(croppedImage, quality: 85),
    );

    // Delete original uncropped image
    await File(image.path).delete();

    return croppedPath;
  }
}
