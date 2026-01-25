import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_source_dialog.dart';

class CameraController {
  static Future<ImageSource?> showImageSourceDialog(
    BuildContext context,
  ) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (ctx) => ImageSourceDialog(
        onTapCamera: () => ctx.pop(ImageSource.camera),
        onTapGallery: () => ctx.pop(ImageSource.gallery),
      ),
    );
  }
}
