import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:pictolog/src/features/bottom_navigation/presentation/widget/bottom_navigation_bar_widget.dart';
import 'package:pictolog/src/features/bottom_navigation/presentation/widget/floating_action_button_widget.dart';
import 'package:pictolog/src/features/home_overview/home_overview_screen.dart';

import '../controller/bottom_navigation_controller.dart';

class BottomNavigation extends HookWidget {
  const BottomNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final controller = BottomNavigationController(
      navigationShell: navigationShell,
    );
    final selectedIndex = useState(0);
    final pictologs = useState<List<String>>([]);

    void addPictolog() {
      pictologs.value = [...pictologs.value, 'Pictolog ${DateTime.now()}'];
    }

    final List<Widget> widgetOptions = <Widget>[
      HomeOverviewScreen(),
      const Center(child: Text('Settings (Placeholder)')),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text('Pictolog')),
      body: navigationShell,
      floatingActionButton: FloatingActionButtonWidget(controller: controller),

      bottomNavigationBar: BottomNavigationBarWidget(controller: controller),
    );
  }
}
