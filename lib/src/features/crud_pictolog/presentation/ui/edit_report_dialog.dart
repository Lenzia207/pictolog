import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictolog/src/widgets/app_text_fields.dart';
import 'package:pictolog/src/widgets/primary_button.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/app_style.dart';
import '../../../../constants/app_text_style.dart';

class EditReportDialog extends StatelessWidget {
  const EditReportDialog({
    super.key,
    required this.onImageChange,
    required this.descriptionController,
    required this.imagePath,
    required this.onSave,
  });

  final VoidCallback onImageChange;
  final TextEditingController descriptionController;
  final String imagePath;
  final VoidCallback onSave;

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
        'Seite bearbeiten',
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
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: p20,
                  bottom: p10,
                ),
                child: Text(
                  "Beschreibung ändern:",
                  style: AppTextStyle.titleMedium,
                ),
              ),

              AppTextField(
                labelText: 'Beschreibung...',
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
                child: const Text('Abbrechen'),
              ),
            ),
            Space.w8,
            Expanded(
              child: PrimaryButton(
                label: 'Speichern',
                onPressed: onSave,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
