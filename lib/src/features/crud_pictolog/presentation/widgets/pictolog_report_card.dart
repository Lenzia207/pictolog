import 'dart:io';

import 'package:flutter/material.dart';
import '../../model/report.dart';

class PictologReportCard extends StatelessWidget {
  const PictologReportCard({
    super.key,
    required this.report,
  });

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              File(report.imagePath),
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Center(
                child: Icon(
                  Icons.broken_image,
                ),
              ),
            ),
          ),
          if (report.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(report.description),
            ),
        ],
      ),
    );
  }
}
