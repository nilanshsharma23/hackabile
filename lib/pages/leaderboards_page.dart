import 'package:flutter/material.dart';
import 'package:hackabile/classes/leaderboard_entry_object.dart';
import 'package:hackabile/functions/get_leaderboard.dart';
import 'package:hackabile/widgets/leaderboard_entry_template.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LeaderboardsPage extends StatefulWidget {
  const LeaderboardsPage({super.key});

  @override
  State<LeaderboardsPage> createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
  late Future<List<LeaderboardEntryObject>> getLeaderboardFuture;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getLeaderboardFuture = getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                "Leaderboard",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              DropdownMenu(
                width: double.infinity,
                decorationBuilder: (context, controller) => InputDecoration(
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  label: Text("Date Range"),
                ),
                initialSelection: false,
                onSelected: (value) {
                  setState(() {
                    getLeaderboardFuture = getLeaderboard(week: value!);
                  });
                },
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: false, label: "Today"),
                  DropdownMenuEntry(value: true, label: "This Week"),
                ],
              ),
              FutureBuilder(
                future: getLeaderboardFuture,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: List.generate(
                          20,
                          (index) => LeaderboardEntryTemplate(
                            leaderboardEntryObject: asyncSnapshot.data![index],
                          ),
                        ),
                      ),
                    );
                  }

                  return Skeletonizer(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: List.generate(
                          6,
                          (index) => LeaderboardEntryTemplate(
                            leaderboardEntryObject: LeaderboardEntryObject(
                              rank: 5,
                              username: BoneMock.fullName,
                              avatarUrl:
                                  "https://avatars.githubusercontent.com/u/270035225?v=4",
                              totalSeconds: 202020,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
