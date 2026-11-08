import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

/// Camera preview cropped to [targetAspectRatio] with a rule-of-thirds grid.
class PreviewCamera extends StatelessWidget {
  const PreviewCamera({
    super.key,
    required this.controller,
    required this.targetAspectRatio,
  });

  final CameraController controller;
  final double targetAspectRatio;

  @override
  Widget build(BuildContext context) {
    final scale = targetAspectRatio * controller.value.aspectRatio;

    return AspectRatio(
      aspectRatio: targetAspectRatio,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppColor.cameraPreview),
            Transform.scale(
              scale: scale,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1 / controller.value.aspectRatio,
                  child: CameraPreview(controller),
                ),
              ),
            ),
            const CustomPaint(painter: _GridPainter()),
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.accentGreen, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.white.withValues(alpha: 0.18)
      ..strokeWidth = 1;

    for (var i = 1; i < 3; i++) {
      final dx = size.width * i / 3;
      final dy = size.height * i / 3;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
