import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackabile/classes/globals.dart';
import 'package:hackabile/widgets/form_field_template.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormState> usernameFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          spacing: 32,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Form(
              key: usernameFormKey,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Change Username", style: TextStyle(fontSize: 24)),
                  FormFieldTemplate(
                    hintText: "Username",
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
                        if (!usernameFormKey.currentState!.validate()) {
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

            TextButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });

                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                sharedPreferences.remove('username');

                Globals.username = null;

                if (context.mounted) {
                  context.go('/username');
                }

                setState(() {
                  loading = false;
                });
              },
              child: Text("Log Out", style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
