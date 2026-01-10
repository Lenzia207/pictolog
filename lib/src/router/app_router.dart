import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/home_overview/home_overview_screen.dart';
import '../features/bottom_navigation/presentation/bottom_navigation.dart';
import 'not_found_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorDashboardKey = GlobalKey<NavigatorState>(
  debugLabel: 'dashboardShell',
);
// final _shellNavigatorGroupsKey = GlobalKey<NavigatorState>(
//   debugLabel: 'groupsShell',
// );
// final _shellNavigatorNewEntryKey = GlobalKey<NavigatorState>(
//   debugLabel: 'newEntryShell',
// );
// final _shellNavigatorAccountKey = GlobalKey<NavigatorState>(
//   debugLabel: 'accountShell',
// );
// final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
//   debugLabel: 'settingsShell',
// );

/// App Navigation by GoRouter is structured with starting off with StatefulShellRoute that represents the bottom Navigation.
/// The branches represent the bottom navigation items.
/// Inside each Branch are the sub-pages from the bottom navigation item
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // the UI shell
          return BottomNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: [
              GoRoute(
                path: HomeOverviewScreen.path,
                name: HomeOverviewScreen.name,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const HomeOverviewScreen()),
                routes: const [
                  // Sub-pages of the dashboard
                  // GoRoute(
                  //   path: SubScreen.path,
                  //   name: SubScreen.name,
                  //   builder: (context, state) => const SubScreen(),
                  // )
                ],
              ),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: _shellNavigatorGroupsKey,
          //   routes: [
          //     GoRoute(
          //       path: MyGroupsScreen.path,
          //       name: MyGroupsScreen.name,
          //       pageBuilder: (context, state) =>
          //           NoTransitionPage(child: MyGroupsScreen()),
          //       routes: [
          //         // Sub-pages of the groups
          //         // QR Scanner
          //         GoRoute(
          //           path: QRScannerScreen.path,
          //           name: QRScannerScreen.name,
          //           pageBuilder: (context, state) =>
          //               const NoTransitionPage(child: QRScannerScreen()),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        const NotFoundScreen(errorMessage: '404 - Page Not Found'),
  );
});
