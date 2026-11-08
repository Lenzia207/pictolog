import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../domain/project_model.dart';
import '../../../reports/domain/report_model.dart';

final projectRepositoryProvider = Provider<ProjectController>((ref) {
  // Note: Hive.box() only works if the box is already opened in main.dart.
  return ProjectController(
    Hive.box<ProjectModel>('pictologs'),
  );
});

class ProjectController {
  ProjectController(this.box);

  final Box<ProjectModel> box;

  /// Add a new Pictolog and return its key
  Future<int> addPictolog(ProjectModel pictolog) async {
    return box.add(pictolog);
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
    await saveChanges(pictolog);
  }

  /// Marks the Pictolog as edited and persists it
  Future<void> saveChanges(ProjectModel pictolog) async {
    pictolog.updatedAt = DateTime.now();
    await pictolog.save();
  }

  /// Delete a Pictolog together with the images of its pages
  Future<void> deletePictolog(ProjectModel pictolog) async {
    for (final report in pictolog.reports) {
      await _deleteImage(report.imagePath);
    }
    await pictolog.delete();
  }

  /// Copies the images into app storage and appends them as pages
  Future<void> addPages(
    ProjectModel pictolog,
    List<String> imagePaths,
  ) async {
    if (imagePaths.isEmpty) return;

    for (final imagePath in imagePaths) {
      final permanentPath = await saveImageToAppStorage(File(imagePath));
      pictolog.reports.add(ReportModel(imagePath: permanentPath));
    }
    await saveChanges(pictolog);
  }

  /// Updates the description and optionally the image of a page
  Future<void> updatePage(
    ProjectModel pictolog,
    ReportModel report, {
    required String description,
    String? newImagePath,
  }) async {
    if (newImagePath != null) {
      final permanentPath = await saveImageToAppStorage(File(newImagePath));
      await _deleteImage(report.imagePath);
      report.imagePath = permanentPath;
    }
    report.description = description;
    await saveChanges(pictolog);
  }

  /// Moves a page to a new position
  Future<void> reorderPages(
    ProjectModel pictolog,
    int oldIndex,
    int newIndex,
  ) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = pictolog.reports.removeAt(oldIndex);
    pictolog.reports.insert(newIndex, item);
    await saveChanges(pictolog);
  }

  /// Delete a single page and its image
  Future<void> deleteReport(
    ProjectModel pictolog,
    ReportModel report,
  ) async {
    await _deleteImage(report.imagePath);
    pictolog.reports.remove(report);
    await saveChanges(pictolog);
  }

  /// Helper to save an image file to the app's document directory
  /// Returns the permanent path to be stored in Hive
  Future<String> saveImageToAppStorage(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    // Prefix with a timestamp so images with the same name don't overwrite each other.
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch}_${path.basename(imageFile.path)}';
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    return savedImage.path;
  }

  Future<void> _deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Log error but continue with database changes
      debugPrint('Error deleting image file: $e');
    }
  }
}
