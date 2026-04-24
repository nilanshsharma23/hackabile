import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: NavigationBar(
        onDestinationSelected: onDestinationSelected,
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        indicatorColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            label: "Leaderboards",
            selectedIcon: Icon(
              Icons.leaderboard,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.view_agenda_outlined),
            label: "Projects",
            selectedIcon: Icon(
              Icons.view_agenda,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
            selectedIcon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
