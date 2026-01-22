import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/theme/theme.dart';

class ButtonClose extends StatelessWidget {
  const ButtonClose({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: AppColor.white,
          size: 32,
        ),
        onPressed: () => context.pop(),
      ),
    );
  }
}
