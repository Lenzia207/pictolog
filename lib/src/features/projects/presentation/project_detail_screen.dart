import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/l10n/localization_extension.dart';
import 'package:pictolog/src/features/projects/presentation/controllers/project_controller.dart';

import '../../../constants/constants.dart';
import '../../../widgets/bottom_action_bar.dart';
import '../../../widgets/circle_icon_button.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/primary_button.dart';
import '../../pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import '../../reports/presentations/controller/report_controller.dart';
import '../../reports/presentations/edit_page_sheet.dart';
import '../../reports/presentations/reorder_pages_screen.dart';
import '../domain/project_model.dart';
import 'new_entry_pictolog_screen.dart';
import 'ui/pictolog_details_overview.dart';
import 'widgets/empty_entries_message.dart';
import 'widgets/pictolog_builder.dart';
import 'widgets/pictolog_report_card.dart';

class PictologDetailsScreen extends ConsumerWidget {
  const PictologDetailsScreen({
    super.key,
    required this.pictologKey,
  });

  static const String path = 'details';
  static const String name = 'PictologDetails';
  static const String paramId = 'id';

  final int pictologKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathParameters = {paramId: pictologKey.toString()};
    final appLanguage = context.appLanguage;

    return PictologBuilder(
      pictologKey: pictologKey,
      builder: (context, pictolog) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(p12, p8, p12, 0),
                child: Row(
                  children: [
                    CircleIconButton(
                      icon: Icons.chevron_left,
                      iconSize: 26,
                      tooltip: appLanguage.back,
                      onPressed: () => context.pop(),
                    ),
                    const Spacer(),
                    CircleIconButton(
                      icon: Icons.edit_outlined,
                      tooltip: appLanguage.editPictolog,
                      onPressed: () => context.pushNamed(
                        NewEntryPictologScreen.editName,
                        pathParameters: pathParameters,
                      ),
                    ),
                    Space.w4,
                    CircleIconButton(
                      icon: Icons.more_vert,
                      tooltip: appLanguage.moreActions,
                      onPressed: () => _showMoreActions(context, ref, pictolog),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: PictologDetailsOverview(
                        pictolog: pictolog,
                        onSortPressed: pictolog.reports.length < 2
                            ? null
                            : () => context.pushNamed(
                                ReorderPagesScreen.name,
                                pathParameters: pathParameters,
                              ),
                      ),
                    ),
                    if (pictolog.reports.isEmpty)
                      const SliverToBoxAdapter(
                        child: EmptyEntriesMessage(),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(p20, 0, p20, p24),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              // Two columns on phones, more on tablets.
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 240,
                                mainAxisSpacing: p12,
                                crossAxisSpacing: p12,
                                mainAxisExtent: PictologReportCard.height,
                              ),
                          itemCount: pictolog.reports.length,
                          itemBuilder: (context, index) => PictologReportCard(
                            report: pictolog.reports[index],
                            index: index,
                            onTap: () => showEditPageSheet(
                              context: context,
                              pictolog: pictolog,
                              report: pictolog.reports[index],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomActionBar(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: p10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: PrimaryButton(
                    label: appLanguage.page,
                    icon: Icons.photo_camera_outlined,
                    variant: PrimaryButtonVariant.secondary,
                    onPressed: () => ref
                        .read(reportControllerProvider)
                        .addPages(context: context, pictolog: pictolog),
                  ),
                ),
                Space.w10,
                Expanded(
                  flex: 16,
                  child: PrimaryButton(
                    label: appLanguage.createPdf,
                    icon: Icons.description_outlined,
                    onPressed: () => context.pushNamed(
                      PictologPdfPreviewScreen.name,
                      pathParameters: pathParameters,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMoreActions(
    BuildContext context,
    WidgetRef ref,
    ProjectModel pictolog,
  ) async {
    final appLanguage = context.appLanguage;
    final shouldDelete = await showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(p20),
          child: PrimaryButton(
            label: appLanguage.deletePictolog,
            icon: Icons.delete_outline,
            variant: PrimaryButtonVariant.danger,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
      ),
    );
    if (shouldDelete != true || !context.mounted) return;

    final confirmed = await showConfirmDialog(
      context: context,
      title: appLanguage.deletePictolog,
      message: appLanguage.deletePictologConfirm,
      confirmLabel: appLanguage.delete,
    );
    if (!confirmed || !context.mounted) return;

    // Leave the screen first so it doesn't rebuild without its Pictolog.
    context.pop();
    await ref.read(projectRepositoryProvider).deletePictolog(pictolog);
  }
}
