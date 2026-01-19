import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_text_style.dart';

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
  final VoidCallback? onSettingsPressed;

  const PictologDetailsAppBar({
    super.key,
    required this.isSelectionMode,
    required this.selectedKeys,
    required this.title,
    required this.onClose,
    required this.onDelete,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSelectionMode,
      builder: (context, selectionMode, _) {
        return AppBar(
          backgroundColor: context.colors.surface.withAlpha(0),
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 2,
          centerTitle: true,
          title: selectionMode
              ? ValueListenableBuilder<Set>(
                  valueListenable: selectedKeys,
                  builder: (context, items, _) {
                    return Text(
                      '${items.length} ausgewählt',
                      style: AppTextStyle.headlineLarge,
                    );
                  },
                )
              : Text(
                  title,
                  style: AppTextStyle.headlineLarge,
                ),
          leading: selectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                )
              : null,
          actions: [
            if (selectionMode)
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              )
            else if (onSettingsPressed != null) ...[
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                ),
                onPressed: onSettingsPressed,
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
