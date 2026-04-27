import 'package:flutter/material.dart';

String formatSeconds({required int totalSeconds}) {
  debugPrint(totalSeconds.toString());
  int hours = totalSeconds ~/ 3600;
  int secondsLeft = totalSeconds.remainder(3600);
  int minutes = secondsLeft ~/ 60;
  int seconds = secondsLeft.remainder(60);

  String output = "";

  if (hours != 0) {
    output += "${hours}h ";
  }

  if (minutes != 0) {
    output += "${minutes}m ";
  }

  if (seconds != 0) {
    output += "${seconds}s";
  }

  return output;
}
