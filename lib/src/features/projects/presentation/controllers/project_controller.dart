import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../domain/project_model.dart';
import '../../../reports/domain/report_model.dart';

final projectRepositoryProvider = Provider<ProjectController>((ref) {
  // We assume the box is already opened in main.dart or we handle opening it here.
  // For simplicity with synchronous access in ValueListenableBuilder, keeping the box open globally is preferred,
  // but here we can open it lazily if needed.
  // Note: Hive.box() only works if the box is already opened.
  return ProjectController(
    Hive.box<ProjectModel>('pictologs'),
  );
});

class ProjectController {
  ProjectController(this.box);

  final Box<ProjectModel> box;

  /// Get all Pictologs Projects
  List<ProjectModel> getAllPictologs() {
    return box.values.toList();
  }

  /// Add a new Pictolog
  Future<void> addPictolog(ProjectModel pictolog) async {
    await box.add(pictolog);
  }

  /// Update an existing Pictolog
  Future<void> updatePictolog(
    ProjectModel pictolog, {
    String? name,
    String? overviewDescription,
  }) async {
    if (name != null) {
      pictolog.name = name;
    }
    if (overviewDescription != null) {
      pictolog.overviewDescription = overviewDescription;
    }
    pictolog.updatedAt = DateTime.now();
    await pictolog.save();
  }

  /// Delete a Pictolog
  Future<void> deletePictolog(ProjectModel pictolog) async {
    // Optional: Delete associated images from disk here to clean up space
    for (var report in pictolog.reports) {
      final file = File(report.imagePath);

      if (await file.exists()) {
        await file.delete();
      }
    }
    await pictolog.delete();
  }

  /// Delete a single report and its image
  Future<void> deleteReport(
    ProjectModel pictolog,
    ReportModel report,
  ) async {
    // Delete image file first
    try {
      final file = File(report.imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Log error but continue with database deletion
      debugPrint('Error deleting image file: $e');
    }

    await report.delete();
    pictolog.reports.remove(report);
    await pictolog.save();
  }

  /// Delete multiple reports and their images (more efficient for bulk deletion)
  Future<void> deleteReports(
    ProjectModel pictolog,
    Set<ReportModel> reports,
  ) async {
    // Delete image files
    for (final report in reports) {
      try {
        final file = File(report.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        debugPrint('Error deleting image file: $e');
      }
    }

    // Remove from pictolog's reports list
    pictolog.reports.removeWhere((r) => reports.contains(r));

    // Save pictolog (this updates the relationship)
    await pictolog.save();

    // Delete report objects from Hive

    await Future.wait(reports.map((report) => report.delete()));
  }

  /// Helper to save an image file to the app's document directory
  /// Returns the permanent path to be stored in Hive
  Future<String> saveImageToAppStorage(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    return savedImage.path;
  }
}
