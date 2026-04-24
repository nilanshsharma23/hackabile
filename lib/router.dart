import 'package:go_router/go_router.dart';
import 'package:hackabile/globals.dart';
import 'package:hackabile/pages/api_key_page.dart';
import 'package:hackabile/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String? apiKey = sharedPreferences.getString('api_key');

    if (apiKey != null) {
      Globals.apiKey = apiKey;
    }

    return apiKey == null ? '/api-key' : '/';
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/api-key', builder: (context, state) => ApiKeyPage()),
  ],
);
