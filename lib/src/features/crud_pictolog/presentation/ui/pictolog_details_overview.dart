import 'package:flutter/material.dart';
import 'package:pictolog/src/constants/app_style.dart';

import '../../model/pictolog.dart';

class PictologDetailsOverview extends StatelessWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
  });

  final Pictolog pictolog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Space.h8,
          Text(
            pictolog.overviewDescription.isNotEmpty
                ? pictolog.overviewDescription
                : 'No description provided.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Space.h16,
          Text(
            'Erstellt: ${pictolog.createdAt.day}.${pictolog.createdAt.month}.${pictolog.createdAt.year}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Divider(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seiten (${pictolog.reports.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Space.h16,
        ],
      ),
    );
  }
}
