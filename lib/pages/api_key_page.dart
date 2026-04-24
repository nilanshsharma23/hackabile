import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackabile/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ApiKeyPage extends StatefulWidget {
  const ApiKeyPage({super.key});

  @override
  State<ApiKeyPage> createState() => _ApiKeyPageState();
}

class _ApiKeyPageState extends State<ApiKeyPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController apiKeyController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                "Enter Your API Key",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Row(
                spacing: 4,
                children: [
                  Text(
                    "Don't have your API key?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () async {
                      await launchUrlString(
                        'https://hackatime.hackclub.com/my/settings/access#user_api_key',
                      );
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      "Get it here!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  hintText: "API Key",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter something.";
                  }

                  final apiKeyRegex = RegExp(
                    r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
                    caseSensitive: false,
                  );

                  if (!apiKeyRegex.hasMatch(value.trim())) {
                    return "Invalid API Key.";
                  }

                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    setState(() {
                      loading = true;
                    });

                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    await sharedPreferences.setString(
                      'api_key',
                      apiKeyController.text.trim(),
                    );

                    Globals.apiKey = apiKeyController.text.trim();

                    if (context.mounted) {
                      context.go('/');
                    }

                    setState(() {
                      loading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: loading
                      ? CircularProgressIndicator()
                      : Text(
                          "CONTINUE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
