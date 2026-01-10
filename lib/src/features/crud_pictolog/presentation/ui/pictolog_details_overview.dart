import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pictolog/src/constants/app_style.dart';

import '../../data/pictolog_repository.dart';
import '../../model/pictolog.dart';

class PictologDetailsOverview extends ConsumerWidget {
  const PictologDetailsOverview({
    super.key,
    required this.pictolog,
  });

  final Pictolog pictolog;

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
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(context, ref, pictolog);
                },
              ),
            ],
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
          if (pictolog.updatedAt != null)
            Text(
              'Bearbeitet: ${pictolog.updatedAt!.day}.${pictolog.updatedAt!.month}.${pictolog.updatedAt!.year}',
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

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    Pictolog pictolog,
  ) async {
    final nameController = TextEditingController(text: pictolog.name);
    final descriptionController = TextEditingController(
      text: pictolog.overviewDescription,
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pictolog bearbeiten'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Name des Pictologs',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Beschreibung',
                hintText: 'Kurze Beschreibung...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () {
              ref
                  .read(pictologRepositoryProvider)
                  .updatePictolog(
                    pictolog,
                    name: nameController.text.trim(),
                    overviewDescription: descriptionController.text.trim(),
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }
}
