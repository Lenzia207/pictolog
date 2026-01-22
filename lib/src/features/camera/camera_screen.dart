import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../constants/constants.dart';

class CameraScreen extends HookWidget {
  const CameraScreen({super.key});

  static const String path = 'camera';
  static const String name = 'Camera';

  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final isInitialized = useState(false);
    final isTakingPicture = useState(false);

    useEffect(() {
      Future<void> initializeCamera() async {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No camera found')),
            );
          }
          return;
        }

        final camera = cameras.first;

        final cameraController = CameraController(
          camera,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );

        await cameraController.initialize();

        try {
          if (context.mounted) {
            controller.value = cameraController;
            isInitialized.value = true;
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error initializing camera: $e')),
            );
          }
        }
      }

      initializeCamera();

      return () {
        controller.value?.dispose();
      };
    }, []);

    Future<void> takePicture() async {
      if (controller.value == null ||
          !controller.value!.value.isInitialized ||
          isTakingPicture.value) {
        return;
      }

      isTakingPicture.value = true;

      try {
        final image = await controller.value!.takePicture();

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

    if (!isInitialized.value || controller.value == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 4:3 aspect ratio for portrait mode
    const targetAspectRatio = 3 / 4;
    final scale = targetAspectRatio * controller.value!.value.aspectRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview centered and cropped to 4:3
          Center(
            child: AspectRatio(
              aspectRatio: targetAspectRatio,
              child: ClipRect(
                child: Transform.scale(
                  scale: scale,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1 / controller.value!.value.aspectRatio,
                      child: CameraPreview(controller.value!),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  // Capture button
                  GestureDetector(
                    onTap: isTakingPicture.value ? null : takePicture,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isTakingPicture.value
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Space.h50,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
