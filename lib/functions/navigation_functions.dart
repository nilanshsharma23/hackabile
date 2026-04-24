import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void onDestinationSelected(BuildContext context, {required int index}) {
  switch (index) {
    case 0:
      GoRouter.of(context).go('/');
      break;
    case 1:
      GoRouter.of(context).go('/leaderboards');
      break;
    case 2:
      GoRouter.of(context).go('/projects');
      break;
    case 3:
      GoRouter.of(context).go('/settings');
      break;
    default:
  }
}

int calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.path;

  if (location == '/leaderboards') {
    return 1;
  } else if (location == '/projects') {
    return 2;
  } else if (location == '/settings') {
    return 3;
  } else {
    return 0;
  }
}
