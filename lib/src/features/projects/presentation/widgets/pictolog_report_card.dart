import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictolog/src/widgets/shiny_card.dart';
import '../../../../constants/constants.dart';
import '../../../reports/domain/report_model.dart';

class PictologReportCard extends StatelessWidget {
  const PictologReportCard({
    super.key,
    required this.report,
    required this.isSelectedItem,
  });

  final ReportModel report;
  final bool isSelectedItem;

  @override
  Widget build(BuildContext context) {
    return ShinyCard(
      isSelected: isSelectedItem,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(
                  report.description?.isNotEmpty ?? false ? 0 : 20,
                ),
                bottomRight: Radius.circular(
                  report.description?.isNotEmpty ?? false ? 0 : 20,
                ),
              ),
              child: Image.file(
                File(report.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          if (report.description?.isNotEmpty ?? false)
            Container(
              padding: const EdgeInsets.all(p12),
              child: Text(
                report.description!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppTextStyle.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}
