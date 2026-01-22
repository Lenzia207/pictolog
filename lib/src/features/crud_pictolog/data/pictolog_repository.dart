import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../model/pictolog.dart';
import '../model/report.dart';

final pictologRepositoryProvider = Provider<PictologRepository>((ref) {
  // We assume the box is already opened in main.dart or we handle opening it here.
  // For simplicity with synchronous access in ValueListenableBuilder, keeping the box open globally is preferred,
  // but here we can open it lazily if needed.
  // Note: Hive.box() only works if the box is already opened.
  return PictologRepository(
    Hive.box<Pictolog>('pictologs'),
  );
});

class PictologRepository {
  PictologRepository(this.box);

  final Box<Pictolog> box;

  /// Get all Pictologs
  List<Pictolog> getAllPictologs() {
    return box.values.toList();
  }

  /// Add a new Pictolog
  Future<void> addPictolog(Pictolog pictolog) async {
    await box.add(pictolog);
  }

  /// Update an existing Pictolog
  Future<void> updatePictolog(
    Pictolog pictolog, {
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
  Future<void> deletePictolog(Pictolog pictolog) async {
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
    Pictolog pictolog,
    Report report,
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
    Pictolog pictolog,
    Set<Report> reports,
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
