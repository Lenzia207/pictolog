// ignore: file_names
import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
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
              context.appLanguage.noEntriesYet,
              style: AppTextStyle.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
