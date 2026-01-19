import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictolog/src/features/crud_pictolog/data/pictolog_repository.dart';

import 'package:pictolog/src/widgets/primary_button.dart';
import '../../../constants/app_style.dart';
import '../../../constants/app_text_style.dart';
import '../../pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import '../controller/pictolog_controller.dart';
import '../data/report_repository.dart';
import '../model/report.dart';
import 'ui/empty_entries_message.dart';
import 'ui/pictolog_detail_floating_button.dart';
import 'ui/pictolog_details_overview.dart';
import 'widgets/pictolog_details_app_bar.dart';
import 'widgets/report_reorderable_list.dart';

class PictologDetailsScreen extends HookConsumerWidget {
  const PictologDetailsScreen({
    super.key,
    required this.pictologKey,
  });

  static const String path = 'details';
  static const String name = 'PictologDetails';
  static const String paramId = 'id';

  final Object pictologKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(pictologRepositoryProvider);
    final isSelectionMode = useState(false);
    final isReorderMode = useState(false);
    final selectedKeys = useState<Set<Report>>({});

    Future<void> deleteSelectedReport() async {
      final pictolog = repository.box.get(pictologKey);

      if (pictolog != null && selectedKeys.value.isNotEmpty) {
        await repository.deleteReports(pictolog, selectedKeys.value);
        selectedKeys.value = {};
        isSelectionMode.value = false;
      }
    }

    return ValueListenableBuilder(
      valueListenable: repository.box.listenable(
        keys: [
          pictologKey,
        ],
      ),
      builder: (context, box, _) {
        final pictolog = box.get(pictologKey);

        if (pictolog == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Pictolog not found',
              ),
            ),
          );
        }

        return Scaffold(
          appBar: PictologDetailsAppBar(
            isSelectionMode: isSelectionMode,
            selectedKeys: selectedKeys,
            title: "Überblick",
            onClose: () {
              isSelectionMode.value = false;
              selectedKeys.value = {};
            },
            onDelete: deleteSelectedReport,
            onSettingsPressed: () {
              final editDialog = ref
                  .read(pictologControllerProvider)
                  .showEditDialog;

              editDialog(context, ref, pictolog);
            },
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PictologDetailsOverview(
                  pictolog: pictolog,
                  title: pictolog.name,
                  icon: Row(
                    spacing: p8,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        isReorderMode.value ? Icons.check : Icons.sort,
                      ),
                      Text(
                        'Seiten Sortieren',
                        style: AppTextStyle.titleMedium,
                      ),
                    ],
                  ),
                  onPressed: () {
                    isReorderMode.value = !isReorderMode.value;
                  },
                ),
                if (pictolog.reports.isEmpty)
                  const EmptyEntriesMessage()
                else ...[
                  ReportReorderableList(
                    pictolog: pictolog,
                    isReorderMode: isReorderMode,
                    isSelectionMode: isSelectionMode,
                    selectedKeys: selectedKeys,
                  ),
                  Space.h50,
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: p10),
                  child: PrimaryButton(
                    label: 'PDF Erstellen',
                    onPressed: () {
                      context.pushNamed(
                        PictologPdfPreviewScreen.name,
                        pathParameters: {
                          PictologDetailsScreen.paramId: pictologKey.toString(),
                        },
                        extra: pictolog,
                      );
                    },
                  ),
                ),

                Space.h300,
              ],
            ),
          ),
          floatingActionButton: PictologDetailFloatingButton(
            onButtonPressed: () {
              final report = ref.read(reportRepositoryProvider);

              report.addReport(
                context: context,
                repository: repository,
                pictolog: pictolog,
              );
            },
          ),
        );
      },
    );
  }
}
