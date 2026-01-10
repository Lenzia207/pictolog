import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';
import '../../config/navigation_config.dart';
import '../../controller/bottom_navigation_controller.dart';

/// Widget: Represents the floating action button in the bottom navigation.
class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    required this.controller,
  });

  final BottomNavigationController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => controller.goBranch(NavigationConfig.fabIndex),
      backgroundColor: AppColor.white,
      child: Icon(
        size: 30,
        NavigationConfig.fabIcon,
        color: controller.isSelected(NavigationConfig.fabIndex)
            ? AppColor.green
            : AppColor.primary,
      ),
    );
  }
}
