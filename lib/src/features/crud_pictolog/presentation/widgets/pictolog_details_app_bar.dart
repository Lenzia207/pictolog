import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';

/// A reusable AppBar that supports a selection mode with a close and
/// delete action, and a normal mode with an optional PDF action.
class PictologDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ValueListenable<bool> isSelectionMode;
  final ValueListenable<Set> selectedKeys;
  final String title;
  final VoidCallback onClose;
  final VoidCallback onDelete;
  final VoidCallback? onPdfPressed;

  const PictologDetailsAppBar({
    super.key,
    required this.isSelectionMode,
    required this.selectedKeys,
    required this.title,
    required this.onClose,
    required this.onDelete,
    this.onPdfPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSelectionMode,
      builder: (context, selectionMode, _) {
        return AppBar(
          backgroundColor: context.colors.surface.withAlpha(0),
          title: selectionMode
              ? ValueListenableBuilder<Set>(
                  valueListenable: selectedKeys,
                  builder: (context, items, _) {
                    return Text('${items.length} ausgewählt');
                  },
                )
              : Text(title),
          leading: selectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                )
              : null,
          actions: [
            if (selectionMode)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              )
            else if (onPdfPressed != null) ...[
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: onPdfPressed,
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
