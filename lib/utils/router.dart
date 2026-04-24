import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackabile/classes/globals.dart';
import 'package:hackabile/pages/api_key_page.dart';
import 'package:hackabile/pages/home_page.dart';
import 'package:hackabile/pages/leaderboards_page.dart';
import 'package:hackabile/pages/projects_page.dart';
import 'package:hackabile/pages/settings_page.dart';
import 'package:hackabile/widgets/navigation/navigation_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/api-key',
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return NavigationScaffold(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(
          path: '/leaderboards',
          builder: (context, state) => LeaderboardsPage(),
        ),
        GoRoute(path: '/projects', builder: (context, state) => ProjectsPage()),
        GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
      ],
    ),
    GoRoute(
      path: '/api-key',
      builder: (context, state) => ApiKeyPage(),
      redirect: (context, state) async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        final String? apiKey = sharedPreferences.getString('api_key');

        if (apiKey != null) {
          Globals.apiKey = apiKey;
        }

        return apiKey == null ? null : '/';
      },
    ),
  ],
);
