// ignore: file_names
import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../../constants/app_style.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Text(
              'Keine Einträge bis jetzt.\nFüge einen neuen Eintrag hinzu!',

              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Space.h20,
          Transform.rotate(
            angle: -math.pi / 5,
            child: const Icon(
              Icons.arrow_downward_rounded,
              size: p50,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
