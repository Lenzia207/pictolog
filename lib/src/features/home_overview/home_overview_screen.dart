import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictolog/src/constants/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/pictolog_details_screen.dart';
import 'package:pictolog/src/features/home_overview/ui/no_pictologs_message.dart';
import 'package:pictolog/src/features/home_overview/ui/pictolog_entry_card.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../l10n/localization_extension.dart';
import '../../constants/app_text_style.dart';
import '../../helper/helper.dart';
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
    final selectedKeys = useState<Set<Pictolog>>({});

    // Deletes all selected pictologs from the repository.
    Future<void> deleteSelected() async {
      final logsToDelete = selectedKeys.value.toList();

      for (final log in logsToDelete) {
        await repository.deletePictolog(log);
      }

      // Reset state
      selectedKeys.value = {};
      isSelectionMode.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.surface.withAlpha(0),
        title: Text(
          isSelectionMode.value
              ? context.appLanguage.selectedItems(selectedKeys.value.length)
              : context.appLanguage.myPictologs,
          // ? '${selectedKeys.value.length} Ausgewählt'
          // : 'Meine Pictologs',
          style: AppTextStyle.headlineLarge,
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
              selectedKeys.value.isNotEmpty
                  ? Icons.delete
                  : Icons.delete_outline,
              color: isSelectionMode.value ? context.colors.accentRed : null,
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
            return NoPictologsMessage();
          }

          return ListView.builder(
            // Use reverse order to show newest first
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              // Calculate reverse index
              final log = logs[logs.length - 1 - index];
              final isSelected = selectedKeys.value.contains(log);

              return PictologEntryCard(
                isSelectedItem: isSelected,
                isSelectionMode: isSelectionMode.value,
                projectName: log.name,
                projectLength: log.reports.length.toString(),
                overviewDescription: log.overviewDescription,
                projectCreatedAt: log.createdAt.toFormatDMY,
                onTapItem: () {
                  if (isSelectionMode.value) {
                    Helper.toggleSelection(selectedKeys, log);
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
                  Helper.toggleSelection(selectedKeys, log);
                },
              );
            },
          );
        },
      ),
    );
  }
}
