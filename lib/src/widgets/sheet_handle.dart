import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

/// Grab handle at the top of a bottom sheet.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: p8),
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: context.colors.outlineStrong,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
