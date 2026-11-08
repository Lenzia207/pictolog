import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/widgets/app_date_format.dart';

import '../../../l10n/localization_extension.dart';
import '../../constants/constants.dart';
import '../../helper/helper.dart';
import '../../theme/theme.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/circle_icon_button.dart';
import '../../widgets/image_thumbnail.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/screen_header.dart';
import '../../widgets/selection_checkbox.dart';
import '../projects/domain/project_model.dart';
import '../projects/presentation/controllers/project_controller.dart';

/// Lets the user select Pictologs to delete them.
class HomeSelectScreen extends HookConsumerWidget {
  const HomeSelectScreen({
    super.key,
    this.initialKey,
  });

  static const String path = 'select';
  static const String name = 'home_select';

  /// Pictolog that is selected when the screen opens.
  final int? initialKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(projectRepositoryProvider);
    final selectedKeys = useState<Set<int>>({?initialKey});
    final isDeleting = useState(false);
    final appLanguage = context.appLanguage;

    return ValueListenableBuilder<Box<ProjectModel>>(
      valueListenable: repository.box.listenable(),
      builder: (context, box, _) {
        final logs = box.values.toList()
          ..sort((a, b) => b.lastEditedAt.compareTo(a.lastEditedAt));
        final selectedLogs = logs
            .where((log) => selectedKeys.value.contains(log.key))
            .toList();
        final pagesToDelete = selectedLogs.fold<int>(
          0,
          (sum, log) => sum + log.reports.length,
        );
        final isAllSelected = selectedLogs.length == logs.length;

        Future<void> deleteSelected() async {
          isDeleting.value = true;
          for (final log in selectedLogs) {
            await repository.deletePictolog(log);
          }
          if (context.mounted) context.pop();
        }

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                ScreenHeader(
                  leading: CircleIconButton(
                    icon: Icons.close,
                    tooltip: appLanguage.endSelection,
                    onPressed: () => context.pop(),
                  ),
                  title: appLanguage.selectedItems(selectedLogs.length),
                  trailing: TextButton(
                    onPressed: () => selectedKeys.value = isAllSelected
                        ? {}
                        : logs.map((log) => log.key as int).toSet(),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colors.textPrimary,
                      textStyle: AppTextStyle.button,
                      minimumSize: const Size(touchTarget, touchTarget),
                    ),
                    child: Text(appLanguage.selectAll),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(p20, p20, p20, p20),
                    itemCount: logs.length,
                    separatorBuilder: (_, _) => Space.h10,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      return _SelectableRow(
                        pictolog: log,
                        isSelected: selectedKeys.value.contains(log.key),
                        onTap: () => selectedKeys.value =
                            Helper.toggleSelection(
                              selectedKeys.value,
                              log.key as int,
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomActionBar(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (selectedLogs.isNotEmpty) ...[
                  Text(
                    appLanguage.pagesWillBeDeleted(pagesToDelete),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.caption.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                  Space.h8,
                ],
                PrimaryButton(
                  label: appLanguage.deletePictologs(selectedLogs.length),
                  icon: Icons.delete_outline,
                  variant: PrimaryButtonVariant.danger,
                  isLoading: isDeleting.value,
                  onPressed: selectedLogs.isEmpty ? null : deleteSelected,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.pictolog,
    required this.isSelected,
    required this.onTap,
  });

  final ProjectModel pictolog;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: isSelected
              ? BorderSide(color: colors.primary, width: 2)
              : BorderSide(color: colors.outline),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(p12, p12, p14, p12),
            child: Row(
              children: [
                SelectionCheckbox(isSelectedItem: isSelected),
                Space.w14,
                ImageThumbnail(
                  imagePath: pictolog.reports.firstOrNull?.imagePath,
                  borderRadius: AppRadius.thumbnail,
                  width: 56,
                  height: 56,
                ),
                Space.w14,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pictolog.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodyLarge.copyWith(
                          fontWeight: AppFontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      Space.h3,
                      Text(
                        '${context.appLanguage.pagesCount(pictolog.reports.length)} · ${pictolog.lastEditedAt.toFormatDMY}',
                        style: AppTextStyle.meta.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
