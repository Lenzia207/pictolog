import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/bottom_navigation/presentation/widget/bottom_navigation_bar_widget.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final controller = BottomNavigationController(
      navigationShell: navigationShell,
    );
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBarWidget(
        controller: controller,
      ),
    );
  }
}
