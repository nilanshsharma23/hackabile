import 'package:flutter/material.dart';
import 'package:hackabile/classes/stats_object.dart';
import 'package:hackabile/functions/get_stats.dart';
import 'package:hackabile/widgets/stats_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<StatsObject> getStatsFuture;

  @override
  void initState() {
    super.initState();
    getStatsFuture = getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            spacing: 16,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "Keep Track of "),
                    TextSpan(
                      text: "Your ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    TextSpan(text: "Coding Time"),
                  ],
                ),
              ),
              DropdownMenu(
                width: double.infinity,
                onSelected: (value) {
                  setState(() {
                    getStatsFuture = getStats(dateTimeRange: value);
                  });
                },
                decorationBuilder: (context, controller) => InputDecoration(
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: null, label: "All Time"),
                  DropdownMenuEntry(
                    value: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(Duration(days: 1)),
                    ),
                    label: "Today",
                  ),
                  DropdownMenuEntry(
                    value: DateTimeRange(
                      start: DateTime.now().subtract(Duration(days: 8)),
                      end: DateTime.now(),
                    ),
                    label: "This Week",
                  ),
                ],
              ),
              FutureBuilder(
                future: getStatsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StatsWidgets(statsObject: snapshot.data!);
                  }

                  return Skeletonizer(
                    child: StatsWidgets(
                      statsObject: StatsObject(
                        totalSeconds: 100000,
                        humanReadableTotal: BoneMock.title,
                        projects: [],
                        languages: [],
                        streak: 2,
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
