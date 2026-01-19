import 'package:flutter/material.dart';
import 'package:pictolog/src/widgets/app_text_fields.dart';
import 'package:pictolog/src/widgets/primary_button.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/app_style.dart';
import '../../../../constants/app_text_style.dart';

class EditEntryDialog extends StatelessWidget {
  const EditEntryDialog({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
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
        'Pictolog bearbeiten',
        style: AppTextStyle.headlineSmall,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: AppTextStyle.titleMedium,
              ),
              Space.h8,
              AppTextField(
                labelText: 'Titel deines Eintrags',
                type: AppTextFieldType.oneLiner,
                controller: nameController,
              ),
              Space.h16,
              Text(
                "Beschreibung",
                style: AppTextStyle.titleMedium,
              ),
              Space.h8,
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
