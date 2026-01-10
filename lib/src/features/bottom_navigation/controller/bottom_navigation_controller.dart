import 'package:go_router/go_router.dart';

/// Controller for managing bottom navigation.
///
/// This controller interacts with the StatefulNavigationShell
/// to handle navigation between different branches of the bottom navigation.
class BottomNavigationController {
  final StatefulNavigationShell navigationShell;

  BottomNavigationController({required this.navigationShell});

  int get currentIndex => navigationShell.currentIndex;

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  bool isSelected(int index) => index == currentIndex;
}
