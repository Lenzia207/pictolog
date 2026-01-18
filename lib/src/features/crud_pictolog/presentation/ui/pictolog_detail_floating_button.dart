import 'package:flutter/material.dart';

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
        onPressed: onButtonPressed,
        label: const Text(
          'Seiten hinzufügen',
        ),
        icon: const Icon(
          Icons.add_a_photo,
        ),
      ),
    );
  }
}
