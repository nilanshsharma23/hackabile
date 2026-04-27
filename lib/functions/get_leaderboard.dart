import 'dart:convert';

import 'package:hackabile/classes/leaderboard_entry_object.dart';
import "package:http/http.dart" as http;

Future<List<LeaderboardEntryObject>> getLeaderboard({bool week = false}) async {
  late Uri uri;

  if (week) {
    uri = Uri.parse("https://hackatime.hackclub.com/api/v1/leaderboard/weekly");
  } else {
    uri = Uri.parse("https://hackatime.hackclub.com/api/v1/leaderboard/daily");
  }

  final response = await http.get(uri);
  final data = jsonDecode(response.body);

  List<LeaderboardEntryObject> output = [];

  for (var i = 0; i < data['entries'].length; i++) {
    var entry = data['entries'][i];

    output.add(
      LeaderboardEntryObject(
        rank: entry['rank'],
        username: entry['user']['username'],
        avatarUrl: entry['user']['avatar_url'],
        totalSeconds: entry['total_seconds'],
      ),
    );
  }

  return output;
}
