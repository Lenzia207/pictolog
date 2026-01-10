import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';
import '../../config/navigation_config.dart';
import '../../controller/bottom_navigation_controller.dart';
import 'tab_item.dart';

/// Widget: Represents the bottom navigation bar of the application.
class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key, required this.controller});

  final BottomNavigationController controller;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: AppColor.white,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 100,
          children: [
            // Left side items
            ...NavigationConfig.items
                .take(2)
                .map(
                  (item) => TabItem(
                    icon: item.icon,
                    label: item.label,
                    index: item.index,
                    currentIndex: controller.currentIndex,
                    onTap: controller.goBranch,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
