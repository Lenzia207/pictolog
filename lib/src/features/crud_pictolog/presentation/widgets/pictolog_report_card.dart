import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../constants/app_color.dart';
import '../../../../constants/app_style.dart';
import '../../model/report.dart';

class PictologReportCard extends StatelessWidget {
  const PictologReportCard({
    super.key,
    required this.report,
    required this.isSelectedItem,
    required this.isSelectionMode,
  });

  final Report report;
  final bool isSelectedItem;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      color: Colors.transparent,
      elevation: isSelectedItem ? 4 : 0,
      shadowColor: context.colors.surface,
      surfaceTintColor: context.colors.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          p10,
        ),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
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
              ),
              if (report.description?.isNotEmpty ?? false)
                Container(
                  color: context.colors.surface,
                  padding: const EdgeInsets.all(
                    p16,
                  ),
                  child: Text(
                    report.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
            ],
          ),
          if (isSelectionMode)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: isSelectedItem
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.grey,
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
