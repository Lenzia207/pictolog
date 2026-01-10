import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../model/pictolog.dart';

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

  /// Helper to save an image file to the app's document directory
  /// Returns the permanent path to be stored in Hive
  Future<String> saveImageToAppStorage(File imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    return savedImage.path;
  }
}
