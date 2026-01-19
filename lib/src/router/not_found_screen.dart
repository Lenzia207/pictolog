import 'package:flutter/material.dart';

import '../constants/app_color.dart';

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
          errorMessage,
          style: TextStyle(
            fontSize: 24,
            color: context.colors.accentRed,
          ),
        ),
      ),
    );
  }
}
