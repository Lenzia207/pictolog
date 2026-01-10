import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/constants/app_style.dart';
import 'package:pictolog/src/features/crud_pictolog/data/pictolog_repository.dart';
import '../model/pictolog.dart';
import '../model/report.dart';

class PictologFullscreenGallery extends HookConsumerWidget {
  const PictologFullscreenGallery({
    super.key,
    required this.pictolog,
    required this.initialIndex,
  });

  final Pictolog pictolog;
  final int initialIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(initialIndex);
    final pageController = usePageController(initialPage: initialIndex);
    // Force rebuild when edit happens
    final rebuildToken = useState(0);

    // State for toggling UI visibility
    final areControlsVisible = useState(true);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. PageView for Images (Background)
          PageView.builder(
            controller: pageController,
            itemCount: pictolog.reports.length,
            onPageChanged: (index) {
              selectedIndex.value = index;
            },
            itemBuilder: (context, index) {
              final report = pictolog.reports[index];
              return _ReportPage(
                key: ValueKey('${report.hashCode}_${rebuildToken.value}'),
                report: report,
                areControlsVisible: areControlsVisible.value,
                onToggleControls: () {
                  areControlsVisible.value = !areControlsVisible.value;
                },
              );
            },
          ),

          // 2. Custom App Bar (Overlay)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: areControlsVisible.value ? 0 : -kToolbarHeight - 50,
            left: 0,
            right: 0,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            child: AppBar(
              backgroundColor: AppColor.background.withValues(alpha: 0.6),
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final currentReport = pictolog.reports[selectedIndex.value];
                    await _showEditDialog(
                      context,
                      ref,
                      currentReport,
                      pictolog,
                      rebuildToken,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    Report report,
    Pictolog pictolog,
    ValueNotifier<int> rebuildToken,
  ) async {
    final descriptionController = TextEditingController(
      text: report.description,
    );
    String? newImagePath;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Eintrag bearbeiten',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        newImagePath = pickedFile.path;
                      });
                    }
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        opacity: 0.6,
                        image: FileImage(
                          File(
                            newImagePath ?? report.imagePath,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white70,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Space.h16,
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Beschreibung',
                    hintText: 'Beschreibung eingeben...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Abbrechen'),
              ),
              FilledButton(
                onPressed: () async {
                  // Update Description
                  report.description = descriptionController.text.trim();

                  // Update Image if changed
                  if (newImagePath != null) {
                    final savedPath = await ref
                        .read(pictologRepositoryProvider)
                        .saveImageToAppStorage(File(newImagePath!));
                    report.imagePath = savedPath;
                  }

                  // Save Changes
                  await pictolog.save();

                  // Trigger UI Rebuild
                  rebuildToken.value++;

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Speichern'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReportPage extends HookWidget {
  final Report report;
  final bool areControlsVisible;
  final VoidCallback onToggleControls;

  const _ReportPage({
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
        if (report.description.isNotEmpty)
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
                              report.description,
                              style: const TextStyle(color: Colors.white),
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
