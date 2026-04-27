import 'package:flutter/material.dart';
import 'package:hackabile/classes/project_object.dart';
import 'package:hackabile/functions/get_stats.dart';
import 'package:hackabile/widgets/project_template.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Future<List<ProjectObject>> getProjectsFuture;

  @override
  void initState() {
    super.initState();
    getProjectsFuture = getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                "My Projects",
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
                onSelected: (value) {
                  setState(() {
                    getProjectsFuture = getProjects(dateTimeRange: value);
                  });
                },
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
                      start: DateTime.now().subtract(Duration(days: 1)),
                      end: DateTime.now(),
                    ),
                    label: "Yesterday",
                  ),
                  DropdownMenuEntry(
                    value: DateTimeRange(
                      start: DateTime.now().subtract(Duration(days: 7)),
                      end: DateTime.now(),
                    ),
                    label: "This Week",
                  ),
                ],
              ),
              FutureBuilder(
                future: getProjectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      spacing: 16,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) => ProjectTemplate(
                          projectObject: snapshot.data![index],
                        ),
                      ),
                    );
                  }

                  return Skeletonizer(
                    child: Column(
                      spacing: 16,
                      children: List.generate(
                        3,
                        (index) => ProjectTemplate(
                          projectObject: ProjectObject(
                            name: BoneMock.title,
                            totalSeconds: 1000,
                            languages: [BoneMock.title, BoneMock.name],
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
