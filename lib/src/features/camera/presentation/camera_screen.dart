import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/circle_icon_button.dart';
import '../../../widgets/image_thumbnail.dart';
import '../../projects/presentation/controllers/project_controller.dart';
import '../domain/camera_repoistory.dart';
import 'widget/camera_button.dart';
import 'widget/preview_camera.dart';

/// Takes photos for a Pictolog.
///
/// By default every photo is added as a new page until the user taps done.
/// With [singleShot] the screen closes after one photo and returns its path.
class CameraScreen extends HookConsumerWidget {
  const CameraScreen({
    super.key,
    required this.pictologKey,
    this.singleShot = false,
  });

  static const String path = 'camera';
  static const String name = 'Camera';

  final int pictologKey;
  final bool singleShot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(projectRepositoryProvider);
    final controller = useState<CameraController?>(null);
    final isTakingPicture = useState(false);
    final pictolog = repository.box.get(pictologKey);
    final pageCount = useState(pictolog?.reports.length ?? 0);
    final lastImagePath = useState(
      pictolog?.reports.lastOrNull?.imagePath,
    );

    useEffect(() {
      CameraController? cameraController;

      Future<void> initializeCamera() async {
        final cameras = await availableCameras();
        if (cameras.isEmpty) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.appLanguage.noCameraFound)),
            );
          }
          return;
        }

        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        await cameraController!.initialize();

        if (context.mounted) {
          controller.value = cameraController;
        }
      }

      initializeCamera();

      return () {
        cameraController?.dispose();
      };
    }, []);

    Future<void> takePicture() async {
      final cameraController = controller.value;
      if (cameraController == null || isTakingPicture.value) return;

      isTakingPicture.value = true;
      try {
        final imagePath = await CameraService.takePicture(cameraController);

        if (singleShot) {
          if (context.mounted) context.pop(imagePath);
          return;
        }

        if (pictolog != null) {
          await repository.addPages(pictolog, [imagePath]);
          pageCount.value = pictolog.reports.length;
          lastImagePath.value = pictolog.reports.last.imagePath;
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.appLanguage.errorTakingPicture(e.toString()),
              ),
            ),
          );
        }
      } finally {
        isTakingPicture.value = false;
      }
    }

    final translucentWhite = AppColor.white.withValues(alpha: 0.14);

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(p16, p8, p16, p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    icon: Icons.close,
                    tooltip: context.appLanguage.closeCamera,
                    backgroundColor: translucentWhite,
                    foregroundColor: AppColor.white,
                    onPressed: () => context.pop(),
                  ),
                  if (!singleShot)
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: p14),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: translucentWhite,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        context.appLanguage.pageNumber(pageCount.value + 1),
                        style: AppTextStyle.caption.copyWith(
                          color: AppColor.white,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: touchTarget),
                ],
              ),
            ),

            // Preview, cropped to the ratio of the saved photo
            Flexible(
              child: controller.value == null
                  ? const AspectRatio(
                      aspectRatio: CameraService.targetAspectRatio,
                      child: ColoredBox(
                        color: AppColor.cameraPreview,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    )
                  : PreviewCamera(
                      controller: controller.value!,
                      targetAspectRatio: CameraService.targetAspectRatio,
                    ),
            ),

            // Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(p30, p24, p30, p30),
              child: Column(
                children: [
                  Text(
                    context.appLanguage.tapShutter,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColor.textSecondaryDark,
                    ),
                  ),
                  Space.h16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (singleShot || lastImagePath.value == null)
                        const SizedBox.square(dimension: 52)
                      else
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppRadius.thumbnail,
                            ),
                            border: Border.all(
                              color: AppColor.white.withValues(alpha: 0.9),
                              width: 2,
                            ),
                          ),
                          child: ImageThumbnail(
                            imagePath: lastImagePath.value,
                            borderRadius: AppRadius.sm,
                          ),
                        ),
                      CameraButton(
                        onTap: controller.value == null || isTakingPicture.value
                            ? null
                            : takePicture,
                        isTakingPicture: isTakingPicture.value,
                      ),
                      if (singleShot)
                        const SizedBox.square(dimension: 52)
                      else
                        CircleIconButton(
                          icon: Icons.check,
                          tooltip: context.appLanguage.done,
                          size: 52,
                          iconSize: 22,
                          backgroundColor: AppColor.accentGreen,
                          foregroundColor: AppColor.black,
                          onPressed: () => context.pop(),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
