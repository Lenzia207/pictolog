import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/new_entry_pictolog_screen.dart';

import '../../../../constants/app_color.dart';
import '../../config/navigation_config.dart';
import '../../controller/bottom_navigation_controller.dart';

/// Widget: Represents the floating action button in the bottom navigation.
class FloatingActionButtonWidget extends HookWidget {
  const FloatingActionButtonWidget({super.key, required this.controller});

  final BottomNavigationController controller;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    // Listen to route changes
    useListenable(router.routeInformationProvider);

    final String location = router.routeInformationProvider.value.uri.path;

    // Only show FAB on the home screen
    if (location != '/') {
      return const SizedBox.shrink();
    }

    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => context.pushNamed(NewEntryPictologScreen.name),
      backgroundColor: AppColor.white,
      child: Icon(size: 30, NavigationConfig.fabIcon, color: AppColor.primary),
    );
  }
}
