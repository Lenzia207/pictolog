import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/crud_pictolog/presentation/new_entry_pictolog_screen.dart';

import '../../../../theme/theme.dart';
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
    // Use GoRouterState.of to reliably rebuild on route changes (including back navigation!)
    final routerState = GoRouterState.of(context);

    // Get the current location
    final String location = routerState.uri.path;

    // Only show FAB on the home screen
    if (location != '/') {
      return const SizedBox.shrink();
    }

    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => context.pushNamed(
        NewEntryPictologScreen.name,
      ),
      backgroundColor: context.colors.accentGreen,
      child: Icon(
        size: 30,
        NavigationConfig.fabIcon,
        color: context.colors.primary,
      ),
    );
  }
}
