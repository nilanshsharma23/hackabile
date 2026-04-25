import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackabile/classes/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

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
                "Enter Your Hackatime Username",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(text: "Don't know your username? "),
                    TextSpan(
                      text: "Get it here!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrlString(
                            'https://hackatime.hackclub.com/my/settings#user_username',
                          );
                        },
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(text: "Make sure you have "),
                    TextSpan(
                      text: "enabled",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrlString(
                            'https://hackatime.hackclub.com/my/settings#user_privacy',
                          );
                        },
                    ),
                    TextSpan(text: " \"Allow public stats lookup\". "),
                  ],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  hintText: "Username",
                ),
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter something.";
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
                      'username',
                      usernameController.text.trim(),
                    );

                    Globals.username = usernameController.text.trim();

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
