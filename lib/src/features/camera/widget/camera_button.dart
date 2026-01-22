import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
    required this.onTap,
    required this.isTakingPicture,
  });

  final VoidCallback? onTap;
  final bool isTakingPicture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(p6),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTakingPicture ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
