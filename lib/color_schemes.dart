import 'package:flutter/material.dart';

class ColorSchemes {
  static const textColor = Color(0xFFffffff);
  static const backgroundColor = Color(0xFF17171d);
  static const primaryColor = Color(0xFFec3750);
  static const primaryFgColor = Color(0xFF17171d);
  static const secondaryColor = Color(0xFF8492a6);
  static const secondaryFgColor = Color(0xFF17171d);
  static const accentColor = Color(0xFF5bc0de);
  static const accentFgColor = Color(0xFF17171d);
  static const elevatedColor = Color(0xFF252429);
  static const borderColor = Color(0xFF252429);

  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: primaryFgColor,
    secondary: secondaryColor,
    onSecondary: secondaryFgColor,
    tertiary: accentColor,
    onTertiary: accentFgColor,
    surface: backgroundColor,
    onSurface: textColor,
    surfaceContainer: elevatedColor,
    outline: borderColor,
    error: Brightness.dark == Brightness.light
        ? Color(0xffB3261E)
        : Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light
        ? Color(0xffFFFFFF)
        : Color(0xff601410),
  );
}
