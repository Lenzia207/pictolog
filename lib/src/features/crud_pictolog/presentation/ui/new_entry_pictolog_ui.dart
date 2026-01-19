import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_style.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/app_text_style.dart';
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
          'Neuer Pictolog Eintrag',
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
                "Titel",
                style: AppTextStyle.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            AppTextField(
              type: AppTextFieldType.oneLiner,
              controller: nameController,
              labelText: 'Name des Projekts',
            ),

            Space.h30,

            // Overview Field
            Padding(
              padding: const EdgeInsets.only(
                left: p8,
                bottom: p10,
              ),
              child: Text(
                "Beschreibung (Optional)",
                style: AppTextStyle.titleLarge,
              ),
            ),

            AppTextField(
              controller: overviewController,
              labelText: 'Allgemeine Beschreibung des Projekts...',
              type: AppTextFieldType.multiLines,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: p30,
              ),
              child: PrimaryButton(
                label: 'Eintrag speichern',
                onPressed: savePictolog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
