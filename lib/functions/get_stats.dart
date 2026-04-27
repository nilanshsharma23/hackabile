import "dart:convert";

import "package:flutter/material.dart";
import "package:hackabile/classes/globals.dart";
import "package:hackabile/classes/languages_object.dart";
import "package:hackabile/classes/project_object.dart";
import "package:hackabile/classes/stats_object.dart";
import "package:hackabile/functions/format_date.dart";
import "package:http/http.dart" as http;

Future<StatsObject> getStats({DateTimeRange? dateTimeRange}) async {
  late Uri uri;
  if (dateTimeRange != null) {
    uri = Uri.parse(
      'https://hackatime.hackclub.com/api/v1/users/${Globals.username!}/stats?start_date=${formatDate(dateTimeRange.start)}?end_date=${formatDate(dateTimeRange.end)}',
    );
  } else {
    uri = Uri.parse(
      'https://hackatime.hackclub.com/api/v1/users/${Globals.username!}/stats',
    );
  }
  final response = await http.get(uri);

  final data = jsonDecode(response.body)['data'];

  List<LanguagesObject> languages = [];

  for (var i = 0; i < data['languages'].length; i++) {
    var language = data['languages'][i];
    languages.add(
      LanguagesObject(
        name: language['name'],
        totalSeconds: language['total_seconds'],
        digital: language['digital'],
        color: Color(
          int.parse(language['color'].substring(1, 7), radix: 16) + 0xFF000000,
        ),
      ),
    );
  }

  return StatsObject(
    totalSeconds: data['total_seconds'],
    humanReadableTotal: data['human_readable_total'],
    projects: await getProjects(dateTimeRange: dateTimeRange),
    languages: languages,
    streak: data['streak'],
  );
}

Future<List<ProjectObject>> getProjects({DateTimeRange? dateTimeRange}) async {
  late Uri uri;
  if (dateTimeRange != null) {
    uri = Uri.parse(
      'https://hackatime.hackclub.com/api/v1/users/${Globals.username!}/projects/details?start_date=${formatDate(dateTimeRange.start)}?end_date=${formatDate(dateTimeRange.end)}',
    );
  } else {
    uri = Uri.parse(
      'https://hackatime.hackclub.com/api/v1/users/${Globals.username!}/projects/details',
    );
  }

  final response = await http.get(uri);
  final data = jsonDecode(response.body)['projects'];

  List<ProjectObject> projects = [];

  for (var i = 0; i < data.length; i++) {
    final project = data[i];

    List<String> languages = [];

    for (var i = 0; i < project['languages'].length; i++) {
      languages.add(project['languages'][i]);
    }

    debugPrint(project.toString());

    projects.add(
      ProjectObject(
        name: project['name'],
        totalSeconds: project['total_seconds'],
        languages: languages,
      ),
    );
  }

  return projects;
}
