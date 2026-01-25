import 'package:flutter/material.dart';

import '../../../../../l10n/localization_extension.dart';
import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';

class AddReportFloatingButton extends StatelessWidget {
  const AddReportFloatingButton({
    super.key,
    required this.onButtonPressed,
  });

  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: p150,
      ),
      child: FloatingActionButton.extended(
        backgroundColor: context.colors.accentGreen,
        onPressed: onButtonPressed,
        label: Text(
          context.appLanguage.addReport,
          style: TextStyle(
            color: context.colors.textPrimary,
          ),
        ),
        icon: Icon(
          Icons.add_a_photo,
          color: context.colors.textPrimary,
        ),
      ),
    );
  }
}
