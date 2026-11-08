import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Shows an image file, or a neutral placeholder when there is none.
class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({
    super.key,
    required this.imagePath,
    required this.borderRadius,
    this.width,
    this.height,
    this.iconSize = 20,
  });

  final String? imagePath;
  final double borderRadius;
  final double? width;
  final double? height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: context.colors.placeholder,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: iconSize,
          color: AppColor.placeholderIcon,
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: imagePath == null
            ? placeholder
            : Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                cacheWidth: 600,
                errorBuilder: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}
