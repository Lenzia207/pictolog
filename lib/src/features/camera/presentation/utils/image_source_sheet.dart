import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/sheet_handle.dart';

/// Bottom sheet that lets the user choose between camera and gallery.
Future<ImageSource?> showImageSourceSheet(BuildContext context) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    useSafeArea: true,
    builder: (context) => const ImageSourceSheet(),
  );
}

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;
    // The camera tile uses the inverted theme, so its secondary text does too.
    final invertedSecondary = Theme.of(context).brightness == Brightness.light
        ? AppColor.textSecondaryDark
        : AppColor.textSecondaryLight;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(p20, 0, p20, p8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            Space.h18,
            Text(
              appLanguage.addPage,
              style: AppTextStyle.sheetTitle.copyWith(
                color: colors.textPrimary,
              ),
            ),
            Space.h4,
            Text(
              appLanguage.whereFromImage,
              style: AppTextStyle.bodySmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
            Space.h18,
            Row(
              children: [
                Expanded(
                  child: _SourceTile(
                    icon: Icons.photo_camera_outlined,
                    title: appLanguage.camera,
                    subtitle: appLanguage.takeNewPhoto,
                    backgroundColor: colors.primary,
                    iconBackgroundColor: colors.accentGreen,
                    iconColor: AppColor.black,
                    titleColor: colors.contrast,
                    subtitleColor: invertedSecondary,
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  ),
                ),
                Space.w12,
                Expanded(
                  child: _SourceTile(
                    icon: Icons.image_outlined,
                    title: appLanguage.gallery,
                    subtitle: appLanguage.chooseExistingImage,
                    backgroundColor: colors.surfaceVariant,
                    iconBackgroundColor: colors.surface,
                    iconColor: colors.textPrimary,
                    titleColor: colors.textPrimary,
                    subtitleColor: colors.textSecondary,
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                ),
              ],
            ),
            Space.h18,
            PrimaryButton(
              label: appLanguage.cancel,
              variant: PrimaryButtonVariant.text,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color titleColor;
  final Color subtitleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.tileLarge),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 132,
          padding: const EdgeInsets.all(p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: touchTarget,
                height: touchTarget,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                ),
                child: Icon(icon, size: 22, color: iconColor),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: AppFontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  Space.h2,
                  Text(
                    subtitle,
                    style: AppTextStyle.meta.copyWith(color: subtitleColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
