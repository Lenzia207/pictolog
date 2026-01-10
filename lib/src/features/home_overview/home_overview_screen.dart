import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/pictolog_details_screen.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/widgets/pictolog_entry_card.dart';

import '../bottom_navigation/config/navigation_config.dart';
import '../crud_pictolog/data/pictolog_repository.dart';
import '../crud_pictolog/model/pictolog.dart';

/// The Overview screen for the home feature.
/// Shows List of created pictologs.
class HomeOverviewScreen extends HookConsumerWidget {
  const HomeOverviewScreen({super.key});
  static const String path = "/";
  static const String name = "home_overview";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the repository provider to get access to the Hive box
    final repository = ref.watch(pictologRepositoryProvider);

    // Selection state
    final isSelectionMode = useState(false);
    final selectedKeys = useState<Set<dynamic>>({});

    // Helper to toggle selection
    void toggleSelection(dynamic key) {
      final newSet = Set<dynamic>.from(selectedKeys.value);

      if (newSet.contains(key)) {
        newSet.remove(key);
      } else {
        newSet.add(key);
      }
      selectedKeys.value = newSet;

      // Optional: Auto-exit selection mode if empty?
      // User might want to unselect all then select others, so maybe keep it active.
      if (newSet.isEmpty && !isSelectionMode.value) {
        // Should not happen if logic is correct
      }
    }

    Future<void> deleteSelected() async {
      final box = repository.box;
      final keysToDelete = selectedKeys.value.toList();

      for (final key in keysToDelete) {
        final log = box.get(key);
        if (log != null) {
          await repository.deletePictolog(log);
        }
      }

      // Reset state
      selectedKeys.value = {};
      isSelectionMode.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isSelectionMode.value
              ? '${selectedKeys.value.length} ausgewählt zum Löschen'
              : 'Meine Pictologs',
        ),
        // Change leading icon in selection mode to allow cancelling
        leading: isSelectionMode.value
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                onPressed: () {
                  isSelectionMode.value = false;
                  selectedKeys.value = {};
                },
              )
            : null,
        actions: [
          IconButton(
            icon: Icon(
              isSelectionMode.value ? Icons.delete : Icons.delete_outline,
              color: isSelectionMode.value ? AppColor.red : null,
            ),
            onPressed: () {
              if (isSelectionMode.value) {
                if (selectedKeys.value.isNotEmpty) {
                  deleteSelected();
                }
              } else {
                // Enter selection mode
                isSelectionMode.value = true;
              }
            },
          ),
        ],
      ),
      // ValueListenableBuilder automatically rebuilds when the box changes (add/delete/update)
      body: ValueListenableBuilder<Box<Pictolog>>(
        valueListenable: repository.box.listenable(),
        builder: (context, box, _) {
          // values is an Iterable, convert to List for easy indexing
          final logs = box.values.toList().cast<Pictolog>();

          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.note_alt_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'Noch keine Pictologs.\nErstelle einen mit dem ',
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            NavigationConfig.fabIcon,
                            size: 20,
                            color: AppColor.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: ' Button!',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            // Use reverse order to show newest first
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              // Calculate reverse index
              final log = logs[logs.length - 1 - index];

              final isSelected = selectedKeys.value.contains(log.key);

              return PictologEntryCard(
                isSelectedItem: isSelected,
                isSelectionMode: isSelectionMode.value,
                projectName: log.name,
                projectLength: log.reports.length.toString(),
                overviewDescription: log.overviewDescription,
                projectCreatedAt:
                    '${log.createdAt.day}.${log.createdAt.month}.${log.createdAt.year}',
                onTapItem: () {
                  if (isSelectionMode.value) {
                    toggleSelection(log.key);
                  } else {
                    context.goNamed(
                      PictologDetailsScreen.name,
                      pathParameters: {
                        PictologDetailsScreen.paramId: log.key.toString(),
                      },
                    );
                  }
                },
                onLongPressed: () {
                  if (!isSelectionMode.value) {
                    isSelectionMode.value = true;
                  }
                  toggleSelection(log.key);
                },
              );
            },
          );
        },
      ),
    );
  }
}
