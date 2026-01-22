import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../theme/theme.dart';

class AppCameraImageService {
  static Future<ImageSource?> showImageSourceDialog(
    BuildContext context,
  ) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
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
              onTap: () => ctx.pop(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: context.colors.primary,
              ),
              title: Text(
                context.appLanguage.gallery,
              ),
              onTap: () => ctx.pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
