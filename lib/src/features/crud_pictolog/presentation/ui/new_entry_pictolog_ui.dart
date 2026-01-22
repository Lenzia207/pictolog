import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/app_text_fields.dart';
import '../../../../widgets/primary_button.dart';

class NewEntryPictologUi extends StatelessWidget {
  const NewEntryPictologUi({
    super.key,
    required this.nameController,
    required this.overviewController,
    required this.icon,
    required this.savePictolog,
  });

  final TextEditingController nameController;
  final TextEditingController overviewController;
  final Widget icon;
  final VoidCallback savePictolog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.surface.withAlpha(0),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 2,
        centerTitle: true,
        title: Text(
          context.appLanguage.newPictologEntry,
          style: AppTextStyle.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: p10,
          vertical: p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            Padding(
              padding: const EdgeInsets.only(
                left: p8,
                bottom: p10,
              ),
              child: Text(
                context.appLanguage.title,
                style: AppTextStyle.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            AppTextField(
              type: AppTextFieldType.oneLiner,
              controller: nameController,
              labelText: context.appLanguage.projectName,
            ),

            Space.h30,

            // Overview Field
            Padding(
              padding: const EdgeInsets.only(
                left: p8,
                bottom: p10,
              ),
              child: Text(
                context.appLanguage.descriptionOptional,
                style: AppTextStyle.titleLarge,
              ),
            ),

            AppTextField(
              controller: overviewController,
              labelText: context.appLanguage.generalProjectDescription,
              type: AppTextFieldType.multiLines,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: p30,
              ),
              child: PrimaryButton(
                label: context.appLanguage.saveEntry,
                onPressed: savePictolog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
