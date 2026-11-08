import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/projects/presentation/new_entry_pictolog_screen.dart';
import 'package:pictolog/src/features/projects/presentation/project_detail_screen.dart';
import 'package:pictolog/src/features/home_overview/home_select_screen.dart';
import 'package:pictolog/src/features/home_overview/ui/no_pictologs_message.dart';
import 'package:pictolog/src/features/home_overview/ui/pictolog_entry_card.dart';
import 'package:pictolog/src/features/home_overview/ui/search_field.dart';

import '../../../l10n/localization_extension.dart';
import '../../constants/constants.dart';
import '../../theme/theme.dart';
import '../../widgets/circle_icon_button.dart';
import '../projects/presentation/controllers/project_controller.dart';
import '../projects/domain/project_model.dart';

/// The Overview screen for the home feature.
/// Shows List of created pictologs.
class HomeOverviewScreen extends HookConsumerWidget {
  const HomeOverviewScreen({super.key});
  static const String path = "/";
  static const String name = "home_overview";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the repository provider to get access to the Hive box
    final repository = ref.watch(projectRepositoryProvider);
    final searchQuery = useState('');
    final isNewestFirst = useState(true);
    final colors = context.colors;
    final appLanguage = context.appLanguage;

    void openSelection([int? initialKey]) => context.pushNamed(
      HomeSelectScreen.name,
      extra: initialKey,
    );

    // ValueListenableBuilder automatically rebuilds when the box changes (add/delete/update)
    return ValueListenableBuilder<Box<ProjectModel>>(
      valueListenable: repository.box.listenable(),
      builder: (context, box, _) {
        final allLogs = box.values.toList();

        if (allLogs.isEmpty) {
          return const NoPictologsMessage();
        }

        final pageTotal = allLogs.fold<int>(
          0,
          (sum, log) => sum + log.reports.length,
        );
        final query = searchQuery.value.trim().toLowerCase();
        final logs =
            allLogs
                .where(
                  (log) =>
                      query.isEmpty ||
                      log.name.toLowerCase().contains(query) ||
                      log.overviewDescription.toLowerCase().contains(query),
                )
                .toList()
              ..sort((a, b) {
                final compare = a.lastEditedAt.compareTo(b.lastEditedAt);
                return isNewestFirst.value ? -compare : compare;
              });

        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.pushNamed(NewEntryPictologScreen.name),
            backgroundColor: colors.accentGreen,
            foregroundColor: AppColor.black,
            elevation: 6,
            shape: const StadiumBorder(),
            icon: const Icon(Icons.add),
            label: Text(
              appLanguage.newPictolog,
              style: AppTextStyle.button,
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(p20, p12, p20, 96),
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLanguage.pictologs,
                            style: AppTextStyle.display.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          Space.h2,
                          Text(
                            '${appLanguage.projectsCount(allLogs.length)} · ${appLanguage.pagesCount(pageTotal)}',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleIconButton(
                      icon: Icons.check_box_outlined,
                      tooltip: appLanguage.selectPictologs,
                      backgroundColor: colors.surface,
                      borderColor: colors.outline,
                      onPressed: openSelection,
                    ),
                  ],
                ),
                Space.h16,
                SearchField(
                  hintText: appLanguage.searchPictologs,
                  onChanged: (value) => searchQuery.value = value,
                ),
                Space.h16,

                // Section header with sort toggle
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appLanguage.recentlyEdited.toUpperCase(),
                        style: AppTextStyle.overline.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          isNewestFirst.value = !isNewestFirst.value,
                      iconAlignment: IconAlignment.end,
                      icon: Icon(
                        isNewestFirst.value
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 16,
                      ),
                      label: Text(
                        isNewestFirst.value
                            ? appLanguage.newestFirst
                            : appLanguage.oldestFirst,
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: colors.textPrimary,
                        textStyle: AppTextStyle.caption.copyWith(
                          fontWeight: AppFontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: p8),
                      ),
                    ),
                  ],
                ),
                Space.h4,

                if (logs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: p40),
                    child: Text(
                      appLanguage.noSearchResults,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),

                for (final log in logs)
                  Padding(
                    key: ValueKey(log.key),
                    padding: const EdgeInsets.only(bottom: p10),
                    child: PictologEntryCard(
                      pictolog: log,
                      onTapItem: () => context.pushNamed(
                        PictologDetailsScreen.name,
                        pathParameters: {
                          PictologDetailsScreen.paramId: log.key.toString(),
                        },
                      ),
                      onLongPressed: () => openSelection(log.key as int),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
