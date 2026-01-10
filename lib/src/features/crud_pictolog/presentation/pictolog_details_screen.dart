import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/data/pictolog_repository.dart';
import 'package:pictolog/src/features/pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/widgets/pictolog_report_card.dart';

import '../../../constants/app_style.dart';
import '../data/report_repository.dart';
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
            title: Text(
              pictolog.name,
            ),
            actions: [
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
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PictologDetailsOverview(
                  pictolog: pictolog,
                ),
                if (pictolog.reports.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text('Keine Einträge bis jetzt.'),
                    ),
                  )
                else
                  SizedBox(
                    height: 360,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pictolog.reports.length,
                      itemBuilder: (context, index) {
                        final report = pictolog.reports[index];
                        return SizedBox(
                          width: 300,
                          child: PictologReportCard(
                            report: report,
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
                'Eintrag hinzufügen',
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
