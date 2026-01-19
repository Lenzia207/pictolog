import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:pictolog/src/constants/app_style.dart';
import 'package:pictolog/src/constants/app_text_style.dart';

import '../../../widgets/selection_checkbox.dart';

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
                        style: AppTextStyle.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Space.h8,
                      if (overviewDescription.isNotEmpty)
                        Text(
                          overviewDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyMedium,
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
                            style: AppTextStyle.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            // Simple date formatting
                            projectCreatedAt,
                            style: AppTextStyle.bodyLarge,
                            // style: Theme.of(context).textTheme.bodySmall,
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
              SelectionCheckbox(
                isSelectedItem: isSelectedItem,
              ),
          ],
        ),
      ),
    );
  }
}
