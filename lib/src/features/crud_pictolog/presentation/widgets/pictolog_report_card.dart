import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../constants/app_style.dart';
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
        horizontal: p16,
        vertical: p8,
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
              padding: const EdgeInsets.all(
                p16,
              ),
              child: Text(
                report.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
        ],
      ),
    );
  }
}
