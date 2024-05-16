import 'package:flutter/material.dart';

const Color primaryColor = Colors.lightGreen;
const Color secondaryColor = Color.fromARGB(255, 0, 120, 4);
const Color bachground = Color.fromARGB(255, 242, 255, 227);

// Define a ColorScheme with primary and secondary colors
ColorScheme myColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: secondaryColor,
  brightness: Brightness.light,
  error: Colors.red,
  surface: Color.fromARGB(209, 127, 201, 42),
  background: bachground,
  onPrimary: Colors.white,
  onSecondary: Color.fromARGB(98, 163, 252, 61),
  onError: Colors.white,
  onSurface: Color.fromARGB(255, 104, 196, 0),
  onBackground: Colors.black,
);
