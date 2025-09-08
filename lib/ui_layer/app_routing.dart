import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "card_detail_popup/detail_popup_main.dart";
import "home_page_widget.dart";

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
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePageWidget(title: "Cloud Tarot");
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/cardDetails/:cardEnum',
          builder: (BuildContext context, GoRouterState state) {
            return DetailPopupMain();
          },
        ),
      ],
    ),
  ],
);
