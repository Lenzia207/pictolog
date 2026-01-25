import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewCamera extends StatelessWidget {
  const PreviewCamera({
    super.key,
    required this.controller,
    required this.targetAspectRatio,
    required this.scale,
  });

  final CameraController controller;
  final double targetAspectRatio;
  final double scale;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: targetAspectRatio,
        child: ClipRect(
          child: Transform.scale(
            scale: scale,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1 / controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
