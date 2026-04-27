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
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                "My Projects",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              FutureBuilder(
                future: getProjects(),
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
