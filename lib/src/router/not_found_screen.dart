import 'package:flutter/material.dart';

import '../../l10n/localization_extension.dart';
import '../theme/theme_colors_extension.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$errorMessage - ${context.appLanguage.pageNotFound}',
          style: TextStyle(
            fontSize: 24,
            color: context.colors.accentRed,
          ),
        ),
      ),
    );
  }
}
