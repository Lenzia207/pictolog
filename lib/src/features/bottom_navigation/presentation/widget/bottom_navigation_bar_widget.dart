import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';
import '../../config/navigation_config.dart';
import '../../controller/bottom_navigation_controller.dart';
import 'tab_item.dart';

/// Represents the bottom navigation bar of the application.
class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.controller,
  });

  final BottomNavigationController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...NavigationConfig.items.map(
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
