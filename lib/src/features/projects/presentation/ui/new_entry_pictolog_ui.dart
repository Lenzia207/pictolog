import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../l10n/localization_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/app_text_fields.dart';
import '../../../../widgets/bottom_action_bar.dart';
import '../../../../widgets/circle_icon_button.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/screen_header.dart';

class NewEntryPictologUi extends StatelessWidget {
  const NewEntryPictologUi({
    super.key,
    required this.isEditing,
    required this.isLoading,
    required this.nameController,
    required this.overviewController,
    required this.titleError,
    required this.onNameChanged,
    required this.savePictolog,
  });

  final bool isEditing;
  final bool isLoading;
  final TextEditingController nameController;
  final TextEditingController overviewController;
  final String? titleError;
  final ValueChanged<String> onNameChanged;
  final VoidCallback savePictolog;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(
              leading: CircleIconButton(
                icon: Icons.close,
                tooltip: appLanguage.close,
                onPressed: () => context.pop(),
              ),
              title: isEditing
                  ? appLanguage.editPictolog
                  : appLanguage.newPictolog,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(p20, p24, p20, p24),
                children: [
                  Text(
                    appLanguage.whatsItAbout,
                    style: AppTextStyle.title.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Space.h6,
                  Text(
                    appLanguage.newPictologHint,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  Space.h22,
                  AppTextField(
                    type: AppTextFieldType.oneLiner,
                    controller: nameController,
                    label: appLanguage.title,
                    hintText: appLanguage.projectName,
                    errorText: titleError,
                    autofocus: !isEditing,
                    onChanged: onNameChanged,
                  ),
                  Space.h22,
                  AppTextField(
                    type: AppTextFieldType.multiLines,
                    controller: overviewController,
                    label: appLanguage.description,
                    trailingLabel: appLanguage.optional,
                    hintText: appLanguage.generalProjectDescription,
                  ),
                  if (!isEditing) ...[
                    Space.h22,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: p16,
                        vertical: p14,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.input),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: colors.accentGreen,
                              borderRadius: BorderRadius.circular(
                                AppRadius.sm,
                              ),
                            ),
                            child: const Icon(
                              Icons.photo_camera_outlined,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ),
                          Space.w12,
                          Expanded(
                            child: Text(
                              appLanguage.newPictologTip,
                              style: AppTextStyle.caption.copyWith(
                                color: colors.textBody,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: BottomActionBar(
          showBorder: false,
          child: PrimaryButton(
            label: isEditing ? appLanguage.save : appLanguage.createPictolog,
            isLoading: isLoading,
            onPressed: savePictolog,
          ),
        ),
      ),
    );
  }
}
