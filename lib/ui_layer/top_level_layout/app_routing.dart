import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../card_detail_popup/detail_popup_main.dart";
// import "home_page_widget.dart";
import "main_scaffold.dart";
import "toplevel_layout.dart";

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

/// The route configuration.
final GoRouter rootRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: "/",
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          name: "home",
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            // return const HomePageWidget(title: "Cloud Tarot");
            return const TopLevelLayout();
          },
          routes: <RouteBase>[
            GoRoute(
              name: "cardDetails",
              path: 'cardDetails/:slotIndex',
              builder: (BuildContext context, GoRouterState state) {
                final int slotIndex = int.parse(
                  state.pathParameters["slotIndex"] ?? "-1",
                );

                return SizedBox(
                  height: 600,
                  width: 800,
                  child: DetailHostWidget(slotIndex: slotIndex),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
