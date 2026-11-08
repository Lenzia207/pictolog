import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pictolog/src/features/home_overview/home_overview_screen.dart';
import '../../l10n/localization_extension.dart';
import '../features/account_settings/account_settings_screen.dart';
import '../features/camera/presentation/camera_screen.dart';
import '../features/home_overview/home_select_screen.dart';
import '../features/projects/presentation/new_entry_pictolog_screen.dart';
import '../features/projects/presentation/project_detail_screen.dart';
import '../features/pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
import '../features/reports/presentations/reorder_pages_screen.dart';
import '../features/bottom_navigation/presentation/bottom_navigation.dart';
import 'not_found_screen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeOverviewKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeOverviewShell',
);
final _shellNavigatorAccountSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'accountSettingsShell',
);

int _pictologKey(GoRouterState state) =>
    int.parse(state.pathParameters[PictologDetailsScreen.paramId]!);

/// App Navigation by GoRouter is structured with starting off with StatefulShellRoute that represents the bottom Navigation.
/// The branches represent the bottom navigation items.
/// Inside each Branch are the sub-pages from the bottom navigation item.
/// Sub-pages use the root navigator so they cover the bottom navigation.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
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
                    path: HomeSelectScreen.path,
                    name: HomeSelectScreen.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => HomeSelectScreen(
                      initialKey: state.extra as int?,
                    ),
                  ),
                  GoRoute(
                    path:
                        '${PictologDetailsScreen.path}/:${PictologDetailsScreen.paramId}',
                    name: PictologDetailsScreen.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => PictologDetailsScreen(
                      pictologKey: _pictologKey(state),
                    ),
                    routes: [
                      GoRoute(
                        path: NewEntryPictologScreen.editPath,
                        name: NewEntryPictologScreen.editName,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => NewEntryPictologScreen(
                          pictologKey: _pictologKey(state),
                        ),
                      ),
                      GoRoute(
                        path: ReorderPagesScreen.path,
                        name: ReorderPagesScreen.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => ReorderPagesScreen(
                          pictologKey: _pictologKey(state),
                        ),
                      ),
                      GoRoute(
                        path: PictologPdfPreviewScreen.path,
                        name: PictologPdfPreviewScreen.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => PictologPdfPreviewScreen(
                          pictologKey: _pictologKey(state),
                        ),
                      ),
                      GoRoute(
                        path: CameraScreen.path,
                        name: CameraScreen.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => CameraScreen(
                          pictologKey: _pictologKey(state),
                          singleShot: state.extra as bool? ?? false,
                        ),
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
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => NotFoundScreen(
      errorMessage: '404 - ${context.appLanguage.pageNotFound}',
    ),
  );
});
