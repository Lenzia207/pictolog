import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme.dart';
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(color: context.colors.outline),
        ),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: p8),
        child: Padding(
          padding: const EdgeInsets.only(top: p10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...NavigationConfig.items(context).map(
                (item) => TabItem(
                  icon: item.icon,
                  label: item.getLabel(context),
                  index: item.index,
                  currentIndex: controller.currentIndex,
                  onTap: controller.goBranch,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
