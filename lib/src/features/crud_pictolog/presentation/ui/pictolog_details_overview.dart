import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../widgets/chips_button.dart';
import '../../model/pictolog.dart';

class PictologDetailsOverview extends ConsumerWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
    required this.title,
    required this.icon,
    required this.onPressedIcon,
  });

  final Pictolog pictolog;
  final String title;
  final IconData icon;
  final VoidCallback onPressedIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.headlineMedium,
                ),
              ),
            ],
          ),
          Space.h8,
          if (pictolog.overviewDescription.isNotEmpty)
            Text(
              pictolog.overviewDescription,
              style: AppTextStyle.bodyMedium,
            ),
          Space.h16,
          Text(
            'Erstellt: ${pictolog.createdAt.toFormatDMY}',
            style: AppTextStyle.bodySmall,
          ),
          if (pictolog.updatedAt != null)
            Text(
              'Bearbeitet: ${pictolog.updatedAt!.toFormatDMY}',
              style: AppTextStyle.bodySmall,
            ),
          const Divider(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seiten (${pictolog.reports.length})',
                style: AppTextStyle.headlineMedium,
              ),
              ChipsButton(
                onPressed: onPressedIcon,
                label: "Reihenfolge ändern",
                icon: icon,
              ),
            ],
          ),
          Space.h16,
        ],
      ),
    );
  }
}
