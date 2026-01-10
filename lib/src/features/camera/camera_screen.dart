import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CameraScreen extends HookWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fetch available cameras once
    final camerasFuture = useMemoized(() => availableCameras());
    final camerasSnapshot = useFuture(camerasFuture);

    // 2. While fetching cameras, show loader or empty
    if (camerasSnapshot.connectionState != ConnectionState.done) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 3. Handle case where no cameras are found
    if (camerasSnapshot.hasError ||
        !camerasSnapshot.hasData ||
        camerasSnapshot.data!.isEmpty) {
      return const Scaffold(body: Center(child: Text('No camera found')));
    }

    final camera = camerasSnapshot.data!.first;

    // 4. Create CameraController.
    // usage of separate memoized allows us to dispose it correctly via useEffect
    final controller = useMemoized(
      () =>
          CameraController(camera, ResolutionPreset.medium, enableAudio: false),
      [camera],
    );

    // 5. Dispose controller when widget is disposed or controller changes
    useEffect(() => controller.dispose, [controller]);

    // 6. Initialize controller actions
    final initFuture = useMemoized(() => controller.initialize(), [controller]);
    final initSnapshot = useFuture(initFuture);

    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture')),
      body: Builder(
        builder: (context) {
          if (initSnapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: 3 / 4,
              child: CameraPreview(controller),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Ensure initialized
            await initFuture;
            final image = await controller.takePicture();
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Picture taken: ${image.path}')),
            );
          } catch (e) {
            debugPrint('Error taking picture: $e');
          }
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
