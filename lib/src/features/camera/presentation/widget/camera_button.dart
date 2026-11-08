import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';

/// The shutter button.
class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
    required this.onTap,
    required this.isTakingPicture,
  });

  final VoidCallback? onTap;
  final bool isTakingPicture;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.appLanguage.takePicture,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(p6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.white,
              width: 4,
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTakingPicture
                  ? AppColor.textSecondaryDark
                  : AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
