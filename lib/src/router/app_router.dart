import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/home_overview/home_overview_screen.dart';
import 'package:pictolog/src/features/crud_pictolog/model/pictolog.dart';
import '../features/account_settings/account_settings_screen.dart';
import '../features/camera/camera_screen.dart';
import '../features/crud_pictolog/presentation/new_entry_pictolog_screen.dart';
import '../features/crud_pictolog/presentation/pictolog_details_screen.dart';
import '../features/pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import '../features/crud_pictolog/presentation/report/report_fullscreen_gallery.dart';
import '../features/bottom_navigation/presentation/bottom_navigation.dart';
import 'not_found_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeOverviewKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeOverviewShell',
);
// );
final _shellNavigatorAccountSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'accountSettingsShell',
);

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
          return BottomNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeOverviewKey,
            routes: [
              GoRoute(
                path: HomeOverviewScreen.path,
                name: HomeOverviewScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const HomeOverviewScreen(),
                ),
                routes: [
                  GoRoute(
                    path: NewEntryPictologScreen.path,
                    name: NewEntryPictologScreen.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const NewEntryPictologScreen(),
                  ),
                  GoRoute(
                    path:
                        '${PictologDetailsScreen.path}/:${PictologDetailsScreen.paramId}',
                    name: PictologDetailsScreen.name,
                    builder: (context, state) {
                      final id =
                          state.pathParameters[PictologDetailsScreen.paramId]!;
                      final key = int.parse(id);
                      return PictologDetailsScreen(
                        pictologKey: key,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: PictologPdfPreviewScreen.path,
                        name: PictologPdfPreviewScreen.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final pictolog = state.extra as Pictolog;
                          return PictologPdfPreviewScreen(
                            pictolog: pictolog,
                          );
                        },
                      ),
                      GoRoute(
                        path: ReportFullscreenGallery.path,
                        name: ReportFullscreenGallery.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final args = state.extra as Map<String, dynamic>;
                          return ReportFullscreenGallery(
                            pictolog: args['pictolog'] as Pictolog,
                            initialIndex: args['index'] as int,
                          );
                        },
                      ),
                      GoRoute(
                        path: CameraScreen.path,
                        name: CameraScreen.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => const CameraScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAccountSettingsKey,
            routes: [
              GoRoute(
                path: AccountSettingsScreen.path,
                name: AccountSettingsScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const AccountSettingsScreen(),
                ),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        const NotFoundScreen(errorMessage: '404 - Page Not Found'),
  );
});
