import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pictolog/src/widgets/shiny_card.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

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
    final colors = context.colors;

    return ShinyCard(
          isSelected: isSelectedItem,
          onTap: onTapItem,
          onLongPress: onLongPressed,
          padding: const EdgeInsets.all(20.0), // Generous padding
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          projectName,
                          style: AppTextStyle.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSelectionMode) const SizedBox(width: 32),
                    ],
                  ),

                  if (overviewDescription.isNotEmpty) ...[
                    Space.h8,
                    Text(
                      overviewDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],

                  Space.h20,

                  // Footer Meta Info
                  Row(
                    children: [
                      // Page Count Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.filter_none_outlined, // More modern icon
                              size: 14,
                              color: colors.textSecondary,
                            ),
                            Space.w6,
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.pagesCount(projectLength),
                              style: AppTextStyle.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Date
                      Text(
                        projectCreatedAt,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: colors.textSecondary.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Selection Indicator
              if (isSelectionMode)
                Positioned(
                  right: 0,
                  top: 0,
                  child: AnimatedContainer(
                    duration: 200.ms,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelectedItem
                          ? colors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelectedItem
                            ? colors.primary
                            : colors.textSecondary.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: isSelectedItem
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: colors.background,
                          ).animate().scale(
                            duration: 200.ms,
                            curve: Curves.easeOutBack,
                          )
                        : null,
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(
          begin: 0.1,
          duration: 400.ms,
          curve: Curves.easeInBack,
        );
  }
}
