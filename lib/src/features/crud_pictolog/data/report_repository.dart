import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pictolog/src/features/crud_pictolog/model/report.dart';

import '../../../constants/app_style.dart';
import '../model/pictolog.dart';
import 'pictolog_repository.dart';

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  // We assume the box is already opened in main.dart or we handle opening it here.
  // For simplicity with synchronous access in ValueListenableBuilder, keeping the box open globally is preferred,
  // but here we can open it lazily if needed.
  // Note: Hive.box() only works if the box is already opened.
  return ReportRepository(
    Hive.box<Report>('reports'),
  );
});

class ReportRepository {
  ReportRepository(this.box);
  final Box<Report> box;

  Future<void> addReport({
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
              SizedBox(
                height: p200,
                child: Image.file(
                  File(pickedFile.path),
                ),
              ),
              Space.h12,
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
}
