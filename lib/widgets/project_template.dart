import 'package:flutter/material.dart';
import 'package:hackabile/classes/project_object.dart';

class ProjectTemplate extends StatelessWidget {
  const ProjectTemplate({super.key, required this.projectObject});

  final ProjectObject projectObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            projectObject.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "14h 47m 58s",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Icon(Icons.code, color: Theme.of(context).colorScheme.secondary),
              Text(
                projectObject.languages.join(', '),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
