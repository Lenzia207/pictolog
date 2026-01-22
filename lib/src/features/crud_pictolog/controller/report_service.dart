import 'package:flutter/material.dart';

import '../presentation/ui/edit_report_dialog.dart';

class ReportController {
  static Future<bool?> saveReportDialog({
    required BuildContext context,
    required VoidCallback onImageChange,
    required TextEditingController descriptionController,
    required String imagePath,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => EditReportDialog(
        onImageChange: onImageChange,
        descriptionController: descriptionController,
        imagePath: imagePath,
        onSave: () => Navigator.pop(ctx, true),
      ),
    );
  }
}
