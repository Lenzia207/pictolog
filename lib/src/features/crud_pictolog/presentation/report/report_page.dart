import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/constants.dart';
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

  static const double minSize = 0.35; // Slightly lower initial height
  static const double maxSize = 0.8;

  @override
  Widget build(BuildContext context) {
    final draggableController = useDraggableScrollableController();
    final colors = context.colors;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background - Dark for better image viewing
        Container(color: Colors.black),

        GestureDetector(
          onTap: onToggleControls,
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 4.0,
            child: Center(
              child: Image.file(
                File(report.imagePath),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      color: colors.textSecondary.withValues(alpha: 0.5),
                      size: 64,
                    ),
                    Space.h16,
                    Text(
                      'Image not found',
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        if (report.description != null && report.description!.isNotEmpty)
          AnimatedOpacity(
            opacity: areControlsVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: DraggableScrollableSheet(
              controller: draggableController,
              initialChildSize: minSize,
              minChildSize: minSize * 0.5, // Allow collapsing further
              maxChildSize: maxSize,
              snap: true,
              snapSizes: const [minSize, maxSize],
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: .85),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: colors.contrast.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            // Drag Handle
                            Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                height: 5,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: colors.textSecondary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            // Content
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                              child: SafeArea(
                                top: false,
                                child: Text(
                                  report.description!,
                                  style: AppTextStyle.bodyLarge.copyWith(
                                    height: 1.6,
                                    color: colors.textPrimary,
                                  ),
                                  textAlign: TextAlign
                                      .start, // Left align for readability
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
