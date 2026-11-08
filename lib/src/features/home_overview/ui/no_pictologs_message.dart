import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/localization_extension.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../../../widgets/primary_button.dart';
import '../../projects/presentation/new_entry_pictolog_screen.dart';

/// Empty state of the home screen.
class NoPictologsMessage extends StatelessWidget {
  const NoPictologsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appLanguage = context.appLanguage;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(p20, p12, p20, p24),
          children: [
            Text(
              appLanguage.pictologs,
              style: AppTextStyle.display.copyWith(
                color: colors.textPrimary,
              ),
            ),
            Space.h2,
            Text(
              appLanguage.noProjectsYet,
              style: AppTextStyle.bodySmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
            Space.h40,
            Container(
              padding: const EdgeInsets.fromLTRB(p24, p40, p24, 32),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.emptyCard),
              ),
              child: Column(
                children: [
                  const _StackedCardsIllustration(),
                  Space.h20,
                  Text(
                    appLanguage.emptyTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.emptyTitle.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Space.h12,
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Text(
                      appLanguage.emptyMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                  Space.h24,
                  PrimaryButton(
                    label: appLanguage.createPictolog,
                    icon: Icons.add,
                    onPressed: () =>
                        context.pushNamed(NewEntryPictologScreen.name),
                  ),
                ],
              ),
            ),
            Space.h24,
            _Step(
              number: 1,
              label: appLanguage.emptyStepCreate,
              isHighlighted: true,
            ),
            Space.h10,
            _Step(number: 2, label: appLanguage.emptyStepPhotos),
            Space.h10,
            _Step(number: 3, label: appLanguage.emptyStepPdf),
          ],
        ),
      ),
    );
  }
}

class _StackedCardsIllustration extends StatelessWidget {
  const _StackedCardsIllustration();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget card(Color color, double angle) => Transform.rotate(
      angle: angle,
      child: Container(
        width: 68,
        height: 82,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.thumbnail),
        ),
      ),
    );

    return SizedBox(
      width: 112,
      height: 96,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 14,
            child: card(colors.placeholderMuted, -0.14),
          ),
          Positioned(
            right: 0,
            top: 14,
            child: card(colors.placeholder, 0.14),
          ),
          Positioned(
            left: 22,
            top: 0,
            child: Container(
              width: 68,
              height: 86,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(AppRadius.thumbnail),
              ),
              child: Icon(
                Icons.photo_camera_outlined,
                size: 28,
                color: colors.accentGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.label,
    this.isHighlighted = false,
  });

  final int number;
  final String label;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isHighlighted ? colors.accentGreen : colors.surface,
          ),
          child: Text(
            '$number',
            style: AppTextStyle.meta.copyWith(
              fontWeight: AppFontWeight.bold,
              color: isHighlighted ? AppColor.black : colors.textPrimary,
            ),
          ),
        ),
        Space.w12,
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(color: colors.textBody),
          ),
        ),
      ],
    );
  }
}
