import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../theme/theme.dart';

class ImageSourceDialog extends StatelessWidget {
  const ImageSourceDialog({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.surface,
      title: Text(context.appLanguage.chooseImageSource),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: context.colors.primary,
            ),
            title: Text(
              context.appLanguage.camera,
            ),
            onTap: onTapCamera,
            // onTap: () => ctx.pop(ImageSource.camera),
          ),
          ListTile(
            leading: Icon(
              Icons.photo_library,
              color: context.colors.primary,
            ),
            title: Text(
              context.appLanguage.gallery,
            ),
            onTap: onTapGallery,
            // onTap: () => ctx.pop(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
