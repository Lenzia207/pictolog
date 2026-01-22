import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants/constants.dart';
import '../../theme/theme.dart';
import '../../widgets/close_button.dart';
import 'repository/camera_repoistory.dart';
import 'widget/camera_button.dart';
import 'widget/preview_camera.dart';

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
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          // Camera preview centered and cropped to 4:3
          PreviewCamera(
            controller: controller.value!,
            scale: scale,
            targetAspectRatio: targetAspectRatio,
          ),
          // Overlay contents - buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Close button
                  const ButtonClose(),
                  // Capture button
                  Center(
                    child: CameraButton(
                      onTap: isTakingPicture.value
                          ? null
                          : () => CameraRepoistory.takePicture(
                              context: context,
                              controller: controller.value!,
                              isInitialized: isInitialized,
                              isTakingPicture: isTakingPicture,
                            ),
                      isTakingPicture: isTakingPicture.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
