import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../theme/theme.dart';
import '../../controller/pictolog_controller.dart';
import '../../model/pictolog.dart';
import 'report_page.dart';

class ReportFullscreenGallery extends HookConsumerWidget {
  const ReportFullscreenGallery({
    super.key,
    required this.pictolog,
    required this.initialIndex,
  });

  static const String path = 'report_fullscreen_gallery';
  static const String name = 'ReportFullscreenGallery';

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
          // PageView for Images (Background)
          PageView.builder(
            controller: pageController,
            itemCount: pictolog.reports.length,
            onPageChanged: (index) {
              selectedIndex.value = index;
            },
            itemBuilder: (context, index) {
              final report = pictolog.reports[index];
              return ReportPage(
                key: ValueKey('${report.hashCode}_${rebuildToken.value}'),
                report: report,
                areControlsVisible: areControlsVisible.value,
                onToggleControls: () {
                  areControlsVisible.value = !areControlsVisible.value;
                },
              );
            },
          ),

          // Custom App Bar (Overlay)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: areControlsVisible.value ? 0 : -kToolbarHeight - 50,
            left: 0,
            right: 0,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            child: AppBar(
              backgroundColor: context.colors.background.withValues(
                alpha: 0.8,
              ),
              iconTheme: IconThemeData(
                color: context.colors.primary,
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.rotate_right,
                    color: context.colors.primary,
                  ),
                  onPressed: () async {
                    final currentReport = pictolog.reports[selectedIndex.value];
                    await ref
                        .read(pictologControllerProvider)
                        .rotateImage(
                          currentReport,
                          rebuildToken,
                        );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: context.colors.primary,
                  ),
                  onPressed: () async {
                    final currentReport = pictolog.reports[selectedIndex.value];
                    final editPageDialog = ref
                        .read(pictologControllerProvider)
                        .showEditPageDialog;

                    await editPageDialog(
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
}
