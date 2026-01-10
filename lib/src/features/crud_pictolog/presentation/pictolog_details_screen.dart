import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/data/pictolog_repository.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import 'package:pictolog/src/features/crud_pictolog/model/report.dart';
import 'package:pictolog/src/features/pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/widgets/pictolog_report_card.dart';

import 'widgets/pictolog_details_overview.dart';

class PictologDetailsScreen extends HookConsumerWidget {
  static const String path = 'details';
  static const String name = 'PictologDetails';
  static const String paramId = 'id';

  final dynamic pictologKey;

  const PictologDetailsScreen({super.key, required this.pictologKey});

  Future<void> _addReport({
    required BuildContext context,
    required PictologRepository repository,
    required Pictolog pictolog,
  }) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      final descriptionController = TextEditingController();

      if (!context.mounted) return;

      // Show dialog for description
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Add Description'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 200, child: Image.file(File(pickedFile.path))),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter report details...',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (shouldSave == true) {
        final permanentPath = await repository.saveImageToAppStorage(
          File(pickedFile.path),
        );
        final newReport = Report(
          imagePath: permanentPath,
          description: descriptionController.text,
        );

        pictolog.reports.add(newReport);
        await pictolog.save(); // HiveObject save
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error adding report: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(pictologRepositoryProvider);

    return ValueListenableBuilder(
      valueListenable: repository.box.listenable(keys: [pictologKey]),
      builder: (context, box, _) {
        final pictolog = box.get(pictologKey);

        if (pictolog == null) {
          return const Scaffold(
            body: Center(child: Text('Pictolog not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(pictolog.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
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
                PictologDetailsOverview(pictolog: pictolog),
                if (pictolog.reports.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('Keine Einträge bis jetzt.'),
                    ),
                  )
                else
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: pictolog.reports.length,
                      itemBuilder: (context, index) {
                        final report = pictolog.reports[index];
                        return SizedBox(
                          width: 300,
                          child: PictologReportCard(report: report),
                        );
                      },
                    ),
                  ),
                // Add some bottom padding for FAB
                const SizedBox(height: 150),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: FloatingActionButton.extended(
              onPressed: () => _addReport(
                context: context,
                repository: repository,
                pictolog: pictolog,
              ),
              label: const Text('Eintrag hinzufügen'),
              icon: const Icon(Icons.add_a_photo),
            ),
          ),
        );
      },
    );
  }
}
