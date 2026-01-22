import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pictolog/src/constants/app_text_style.dart';

import '../../../../constants/app_style.dart';
import '../../../../theme/theme.dart';
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

  static const double minSize = 0.40;
  static const double maxSize = .8;

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
              errorBuilder: (_, _, _) => Center(
                child: Icon(
                  Icons.broken_image,
                  color: context.colors.surface,
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
              initialChildSize: minSize,
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
                        color: context.colors.surface.withValues(
                          alpha: opacity,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40),
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
                              vertical: p20,
                            ),
                            height: 4,
                            width: 40,
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              borderRadius: BorderRadius.circular(p20),
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
                              style: AppTextStyle.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
