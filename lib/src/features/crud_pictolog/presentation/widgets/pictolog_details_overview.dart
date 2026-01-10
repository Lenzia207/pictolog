import 'package:flutter/material.dart';

import '../../model/pictolog.dart';

class PictologDetailsOverview extends StatelessWidget {
  const PictologDetailsOverview({super.key, required this.pictolog});

  final Pictolog pictolog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            pictolog.overviewDescription.isNotEmpty
                ? pictolog.overviewDescription
                : 'No description provided.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Erstellt: ${pictolog.createdAt.day}.${pictolog.createdAt.month}.${pictolog.createdAt.year}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Einträge (${pictolog.reports.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
