import 'package:flutter/material.dart';
import 'package:hackabile/functions/get_stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            debugPrint((await getStats()).toString());
          },
          child: Text("Hojme"),
        ),
      ),
    );
  }
}
