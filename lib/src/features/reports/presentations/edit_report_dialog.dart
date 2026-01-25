import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictolog/src/widgets/app_text_fields.dart';
import 'package:pictolog/src/widgets/primary_button.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class EditReportDialog extends StatelessWidget {
  const EditReportDialog({
    super.key,
    required this.onImageChange,
    required this.descriptionController,
    required this.imagePath,
    required this.onSave,
    this.onRotate,
  });

  final VoidCallback onImageChange;
  final TextEditingController descriptionController;
  final String imagePath;
  final VoidCallback onSave;
  final VoidCallback? onRotate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: p16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(p12),
      ),
      title: Text(
        context.appLanguage.editReport,
        style: AppTextStyle.headlineLarge,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onImageChange,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(p20),
                        image: DecorationImage(
                          opacity: 0.6,
                          image: FileImage(
                            File(
                              imagePath,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColor.black,
                          size: 40,
                        ),
                      ),
                    ),
                    if (onRotate != null)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colors.surface.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.rotate_right,
                              color: context.colors.primary,
                            ),
                            onPressed: onRotate,
                            tooltip: 'Rotate',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: p20,
                  bottom: p10,
                ),
                child: Text(
                  context.appLanguage.description,
                  style: AppTextStyle.titleMedium,
                ),
              ),

              AppTextField(
                labelText: context.appLanguage.generalProjectDescription,
                type: AppTextFieldType.multiLines,
                controller: descriptionController,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(
        left: p16,
        right: p16,
        bottom: p16,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: context.colors.textSecondary,
                ),
                child: Text(context.appLanguage.cancel),
              ),
            ),
            Space.w8,
            Expanded(
              child: PrimaryButton(
                label: context.appLanguage.save,
                onPressed: onSave,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
