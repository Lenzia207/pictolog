import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/data/pictolog_repository.dart';
import 'package:pictolog/src/features/pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/report/report_fullscreen_gallery.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/widgets/pictolog_report_card.dart';

import '../../../constants/app_style.dart';
import '../../../helper/helper.dart';
import '../data/report_repository.dart';
import '../model/report.dart';
import 'ui/pictolog_details_overview.dart';

class PictologDetailsScreen extends HookConsumerWidget {
  const PictologDetailsScreen({
    super.key,
    required this.pictologKey,
  });

  static const String path = 'details';
  static const String name = 'PictologDetails';
  static const String paramId = 'id';

  final dynamic pictologKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(pictologRepositoryProvider);
    final isSelectionMode = useState(false);
    final isReorderMode = useState(false);
    final selectedKeys = useState<Set<Report>>({});

    Future<void> deleteSelected() async {
      final box = repository.box;
      final pictolog = box.get(pictologKey);

      if (pictolog != null && selectedKeys.value.isNotEmpty) {
        pictolog.reports.removeWhere((r) => selectedKeys.value.contains(r));
        await pictolog.save();
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
          appBar: AppBar(
            title: isSelectionMode.value
                ? Text('${selectedKeys.value.length} ausgewählt')
                : Text(
                    pictolog.name,
                  ),
            leading: isSelectionMode.value
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      isSelectionMode.value = false;
                      selectedKeys.value = {};
                    },
                  )
                : null,
            actions: [
              if (isSelectionMode.value)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: deleteSelected,
                )
              else ...[
                IconButton(
                  icon: const Icon(
                    Icons.picture_as_pdf,
                  ),

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
              ],
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PictologDetailsOverview(
                  pictolog: pictolog,
                  icon: Row(
                    spacing: p8,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        isReorderMode.value ? Icons.check : Icons.sort,
                      ),
                      Text(
                        'Seiten Sortieren',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  onPressed: () {
                    isReorderMode.value = !isReorderMode.value;
                  },
                ),
                if (pictolog.reports.isEmpty)
                  const Center(
                    child: Text(
                      'Keine Einträge bis jetzt.',
                    ),
                  )
                else
                  SizedBox(
                    height: 360,
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.horizontal,
                      buildDefaultDragHandles: isReorderMode.value,
                      itemCount: pictolog.reports.length,
                      onReorder: (oldIndex, newIndex) async {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = pictolog.reports.removeAt(oldIndex);
                        pictolog.reports.insert(newIndex, item);
                        await pictolog.save();
                      },
                      itemBuilder: (context, index) {
                        final reports = pictolog.reports;
                        final report = reports[index];

                        final isSelected = selectedKeys.value.contains(
                          report,
                        );

                        return GestureDetector(
                          key: ValueKey(report),
                          onLongPress: isReorderMode.value
                              ? null
                              : () {
                                  if (!isSelectionMode.value) {
                                    isSelectionMode.value = true;
                                  }
                                  Helper.toggleSelection(selectedKeys, report);
                                },
                          onTap: isReorderMode.value
                              ? null
                              : () {
                                  if (isSelectionMode.value) {
                                    Helper.toggleSelection(
                                      selectedKeys,
                                      report,
                                    );
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReportFullscreenGallery(
                                              pictolog: pictolog,
                                              initialIndex: index,
                                            ),
                                      ),
                                    );
                                  }
                                },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                child: PictologReportCard(
                                  isSelectedItem: isSelected,
                                  isSelectionMode: isSelectionMode.value,
                                  report: report,
                                ),
                              ),
                              if (isReorderMode.value)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(
                                    Icons.drag_indicator,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Space.h200,
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              bottom: p120,
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                final report = ref.read(reportRepositoryProvider);

                report.addReport(
                  context: context,
                  repository: repository,
                  pictolog: pictolog,
                );
              },
              label: const Text(
                'Seiten hinzufügen',
              ),
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
          ),
        );
      },
    );
  }
}
