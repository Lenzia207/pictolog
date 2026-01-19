import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/constants/app_style.dart';

class PictologEntryCard extends StatelessWidget {
  const PictologEntryCard({
    super.key,
    required this.isSelectedItem,
    required this.isSelectionMode,
    required this.onLongPressed,
    required this.onTapItem,
    required this.projectName,
    required this.projectLength,
    required this.projectCreatedAt,
    required this.overviewDescription,
  });

  final bool isSelectedItem;
  final bool isSelectionMode;
  final void Function()? onTapItem;
  final void Function()? onLongPressed;
  final String projectName;
  final String projectLength;
  final String projectCreatedAt;
  final String overviewDescription;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      elevation: isSelectedItem ? 4 : 2,
      color: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelectedItem
            ? BorderSide(
                color: context.colors.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTapItem,
        onLongPress: onLongPressed,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Space.h8,
                      if (overviewDescription.isNotEmpty)
                        Text(
                          overviewDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      Space.h12,
                      Row(
                        children: [
                          const Icon(
                            Icons.photo_library,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Space.w4,
                          Text(
                            '$projectLength Seiten',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            // Simple date formatting
                            projectCreatedAt,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Selection Checkbox Overlay
            if (isSelectionMode)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelectedItem
                        ? context.colors.accentRed
                        : context.colors.surface,
                  ),
                  child: isSelectedItem
                      ? Icon(
                          Icons.check_circle,
                          color: context.colors.surface,
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          color: context.colors.primary,
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
