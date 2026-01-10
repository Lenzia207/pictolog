import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/new_entry_pictolog_screen.dart';

import '../../../../constants/app_color.dart';
import '../../config/navigation_config.dart';
import '../../controller/bottom_navigation_controller.dart';

/// Widget: Represents the floating action button in the bottom navigation.
class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, required this.controller});

  final BottomNavigationController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => context.pushNamed(NewEntryPictologScreen.name),
      backgroundColor: AppColor.white,
      child: Icon(size: 30, NavigationConfig.fabIcon, color: AppColor.primary),
    );
  }
}
