import 'package:hackabile/classes/languages_object.dart';
import 'package:hackabile/classes/project_object.dart';

class StatsObject {
  StatsObject({
    required this.totalSeconds,
    required this.humanReadableTotal,
    required this.projects,
    required this.languages,
    required this.streak,
  });

  String humanReadableTotal;
  int totalSeconds;
  List<LanguagesObject> languages;
  List<ProjectObject> projects;
  int streak;
}
