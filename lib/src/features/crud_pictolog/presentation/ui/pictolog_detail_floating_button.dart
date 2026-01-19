import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';
import '../../../../constants/app_style.dart';

class PictologDetailFloatingButton extends StatelessWidget {
  const PictologDetailFloatingButton({
    super.key,
    required this.onButtonPressed,
  });

  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: p120,
      ),
      child: FloatingActionButton.extended(
        backgroundColor: context.colors.accentGreen,
        onPressed: onButtonPressed,
        label: Text(
          'Seiten hinzufügen',
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
