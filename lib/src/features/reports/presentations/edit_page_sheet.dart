import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/app_text_fields.dart';
import '../../../widgets/circle_icon_button.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/sheet_handle.dart';
import '../../projects/domain/project_model.dart';
import '../../projects/presentation/controllers/project_controller.dart';
import '../domain/report_model.dart';
import 'controller/report_controller.dart';

/// Opens the sheet to edit image and description of a page.
Future<void> showEditPageSheet({
  required BuildContext context,
  required ProjectModel pictolog,
  required ReportModel report,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => EditPageSheet(
      pictolog: pictolog,
      report: report,
    ),
  );
}

class EditPageSheet extends HookConsumerWidget {
  const EditPageSheet({
    super.key,
    required this.pictolog,
    required this.report,
  });

  final ProjectModel pictolog;
  final ReportModel report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;
    final repository = ref.watch(projectRepositoryProvider);
    final reportController = ref.watch(reportControllerProvider);

    final descriptionController = useTextEditingController(
      text: report.description,
    );
    // A newly chosen image, applied when saving.
    final newImagePath = useState<String?>(null);
    // Bumped after rotating so the image is reloaded from disk.
    final imageVersion = useState(0);
    final isSaving = useState(false);
    final imagePath = newImagePath.value ?? report.imagePath;

    Future<void> replaceImage() async {
      final path = await reportController.pickReplacementImage(
        context: context,
        pictolog: pictolog,
      );
      if (path != null) newImagePath.value = path;
    }

    Future<void> rotateImage() async {
      await reportController.rotateImage(imagePath);
      if (newImagePath.value == null) {
        // The saved image changed, refresh the pages grid as well.
        await repository.saveChanges(pictolog);
      }
      imageVersion.value++;
    }

    Future<void> deletePage() async {
      final confirmed = await showConfirmDialog(
        context: context,
        title: appLanguage.deletePage,
        message: appLanguage.deletePageConfirm,
        confirmLabel: appLanguage.delete,
      );
      if (!confirmed || !context.mounted) return;

      Navigator.of(context).pop();
      await repository.deleteReport(pictolog, report);
    }

    Future<void> save() async {
      isSaving.value = true;
      await repository.updatePage(
        pictolog,
        report,
        description: descriptionController.text.trim(),
        newImagePath: newImagePath.value,
      );
      if (context.mounted) Navigator.of(context).pop();
    }

    final imageButtonShadow = [
      BoxShadow(
        color: AppColor.black.withValues(alpha: 0.12),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(p20, 0, p20, p16),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              Space.h8,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLanguage
                              .pageOf(
                                pictolog.reports.indexOf(report) + 1,
                                pictolog.reports.length,
                              )
                              .toUpperCase(),
                          style: AppTextStyle.overline.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        Text(
                          appLanguage.editPage,
                          style: AppTextStyle.sheetTitle.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleIconButton(
                    icon: Icons.close,
                    tooltip: appLanguage.close,
                    backgroundColor: colors.surfaceVariant,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Space.h18,

              // Image with replace and rotate actions
              SizedBox(
                height: 320,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      child: ColoredBox(
                        color: colors.placeholder,
                        child: Image.file(
                          File(imagePath),
                          key: ValueKey('$imagePath-${imageVersion.value}'),
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.broken_image_outlined,
                            color: AppColor.placeholderIcon,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: p12,
                      bottom: p12,
                      child: Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                              boxShadow: imageButtonShadow,
                            ),
                            child: SizedBox(
                              height: 40,
                              child: FilledButton.icon(
                                onPressed: replaceImage,
                                icon: const Icon(Icons.refresh, size: 18),
                                label: Text(appLanguage.replace),
                                style: FilledButton.styleFrom(
                                  backgroundColor: colors.surface,
                                  foregroundColor: colors.textPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: p14,
                                  ),
                                  textStyle: AppTextStyle.caption.copyWith(
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Space.w8,
                          DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: imageButtonShadow,
                            ),
                            child: CircleIconButton(
                              icon: Icons.rotate_right,
                              tooltip: appLanguage.rotateImage,
                              size: 40,
                              iconSize: 18,
                              backgroundColor: colors.surface,
                              onPressed: rotateImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Space.h20,
              AppTextField(
                controller: descriptionController,
                label: appLanguage.description,
                type: AppTextFieldType.multiLines,
                lines: 3,
              ),
              Space.h24,
              Row(
                children: [
                  CircleIconButton(
                    icon: Icons.delete_outline,
                    tooltip: appLanguage.deletePage,
                    size: 52,
                    foregroundColor: colors.accentRed,
                    backgroundColor: colors.surface,
                    borderColor: colors.accentRed.withValues(alpha: 0.35),
                    onPressed: deletePage,
                  ),
                  Space.w10,
                  Expanded(
                    child: PrimaryButton(
                      label: appLanguage.save,
                      isLoading: isSaving.value,
                      onPressed: save,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
