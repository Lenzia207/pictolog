import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';
import 'package:pictolog/src/widgets/shiny_card.dart';

import '../../../../../l10n/localization_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/chips_button.dart';
import '../../domain/project_model.dart';

class PictologDetailsOverview extends ConsumerWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
    required this.title,
    required this.icon,
    required this.onPressedIcon,
  });

  final ProjectModel pictolog;
  final String title;
  final IconData icon;
  final VoidCallback onPressedIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Info Card
          ShinyCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (pictolog.overviewDescription.isNotEmpty) ...[
                      Space.h12,
                      Text(
                        pictolog.overviewDescription,
                        style: AppTextStyle.bodyMedium.copyWith(
                          height: 1.5,
                          color: colors.textPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                    Space.h20,
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _DateBadge(
                          label: context.appLanguage.created,
                          date: pictolog.createdAt.toFormatDMY,
                          icon: Icons.calendar_today_outlined,
                          colors: colors,
                        ),
                        if (pictolog.updatedAt != null)
                          _DateBadge(
                            label: context.appLanguage.edited,
                            date: pictolog.updatedAt!.toFormatDMY,
                            icon: Icons.edit_calendar_outlined,
                            colors: colors,
                          ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(
                begin: -0.1,
                duration: 400.ms,
                curve: Curves.easeOutQuad,
              ),

          Space.h20,

          // List Header with Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    context.appLanguage.pages,
                    style: AppTextStyle.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Space.w8,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      pictolog.reports.length.toString(),
                      style: AppTextStyle.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              ChipsButton(
                onPressed: onPressedIcon,
                label: context.appLanguage.changeOrder,
                icon: icon,
              ),
            ],
          ).animate().fadeIn(delay: 200.ms),
          Space.h8,
        ],
      ),
    );
  }
}

// TODO make this a reusable widget
class _DateBadge extends StatelessWidget {
  const _DateBadge({
    required this.label,
    required this.date,
    required this.icon,
    required this.colors,
  });

  final String label;
  final String date;
  final IconData icon;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: colors.textSecondary,
        ),
        Space.w6,
        Text(
          '$label: ',
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.textSecondary,
          ),
        ),
        Text(
          date,
          style: AppTextStyle.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
