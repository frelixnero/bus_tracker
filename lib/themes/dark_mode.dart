import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 0, 5, 12),
    primary: Color.fromARGB(255, 20, 30, 40),
    secondary: Color.fromARGB(255, 40, 60, 80),
    tertiary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade100,
    primaryContainer: Colors.black,
    onPrimary: Color.fromARGB(255, 0, 5, 12),
    onSecondary: Colors.grey.shade800,
  ),
);
