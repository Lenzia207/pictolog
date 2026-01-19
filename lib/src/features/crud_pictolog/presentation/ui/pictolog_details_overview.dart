import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/app_text_style.dart';
import '../../model/pictolog.dart';

class PictologDetailsOverview extends ConsumerWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final Pictolog pictolog;
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

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
          Text(
            pictolog.overviewDescription.isNotEmpty
                ? pictolog.overviewDescription
                : 'No description provided.',
            style: AppTextStyle.bodyMedium,
          ),
          Space.h16,
          Text(
            'Erstellt: ${pictolog.createdAt.day}.${pictolog.createdAt.month}.${pictolog.createdAt.year}',
            style: AppTextStyle.bodySmall,
          ),
          if (pictolog.updatedAt != null)
            Text(
              'Bearbeitet: ${pictolog.updatedAt!.day}.${pictolog.updatedAt!.month}.${pictolog.updatedAt!.year}',
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
              IconButton(
                icon: icon,
                onPressed: onPressed,
              ),
            ],
          ),
          Space.h16,
        ],
      ),
    );
  }
}
