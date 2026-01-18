import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/app_color.dart';
import '../../model/report.dart';

class ReportPage extends HookWidget {
  final Report report;
  final bool areControlsVisible;
  final VoidCallback onToggleControls;

  const ReportPage({
    super.key,
    required this.report,
    required this.areControlsVisible,
    required this.onToggleControls,
  });

  static const double minSize = 0.18;
  static const double maxSize = 1.0;

  @override
  Widget build(BuildContext context) {
    final draggableController = useDraggableScrollableController();

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: onToggleControls,
          child: InteractiveViewer(
            child: Image.file(
              File(report.imagePath),
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ),
        ),
        if (report.description != null && report.description!.isNotEmpty)
          AnimatedOpacity(
            opacity: areControlsVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: DraggableScrollableSheet(
              controller: draggableController,
              initialChildSize: 0.38,
              minChildSize: minSize,
              maxChildSize: maxSize,
              snap: true,
              builder: (context, scrollController) {
                return AnimatedBuilder(
                  animation: draggableController,
                  builder: (context, child) {
                    double opacity = 0.8;
                    if (draggableController.isAttached) {
                      final size = draggableController.size;
                      // Interpolate between 0.8 and 1.0 based on size
                      final t = (size - minSize) / (maxSize - minSize);
                      opacity = 0.8 + (0.2 * t);
                      opacity = opacity.clamp(0.9, 1.0);
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColor.primary.withValues(
                          alpha: opacity,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            height: 4,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: SafeArea(
                            top: false,
                            child: Text(
                              report.description ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
