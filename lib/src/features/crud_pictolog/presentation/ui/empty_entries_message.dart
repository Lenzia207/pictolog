// ignore: file_names
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/app_text_style.dart';

class EmptyEntriesMessage extends StatelessWidget {
  const EmptyEntriesMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: p20,
              vertical: p30,
            ),
            child: Text(
              'Keine Einträge bis jetzt.\n\nFüge einen neuen Eintrag hinzu unter\n"Seiten hinzufügen"',

              style: AppTextStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
