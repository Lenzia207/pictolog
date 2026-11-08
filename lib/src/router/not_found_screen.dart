import 'package:flutter/material.dart';

import '../constants/constants.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: AppTextStyle.section.copyWith(
            color: context.colors.accentRed,
          ),
        ),
      ),
    );
  }
}
