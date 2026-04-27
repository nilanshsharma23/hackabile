import 'package:flutter/material.dart';
import 'package:hackabile/classes/project_object.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ProjectObject> chartData = [
    ProjectObject(name: "Hello", totalSeconds: 2020, languages: ["Dart"]),
    ProjectObject(name: "Sup", totalSeconds: 2000, languages: ["Dart"]),
    ProjectObject(name: "Why", totalSeconds: 3000, languages: ["Dart"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              decorationBuilder: (context, controller) => InputDecoration(
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
