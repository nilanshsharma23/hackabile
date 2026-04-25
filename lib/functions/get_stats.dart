import "package:hackabile/classes/globals.dart";
import "package:http/http.dart" as http;

Future<String> getStats() async {
  Uri uri = Uri.parse(
    'https://hackatime.hackclub.com/api/v1/users/${Globals.username!}/stats',
  );
  final response = await http.get(uri);

  return response.body;
}
