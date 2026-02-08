import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  primaryColor: Colors.orange,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
    brightness: Brightness.light,
    primary: Colors.orange,
    secondary: Colors.orangeAccent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0,
  ),
  cardColor: Colors.white,
  dividerColor: const Color(0xFFE0E0E0),
  iconTheme: const IconThemeData(
    color: Colors.black87,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      color: Colors.black54,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
    ),
  ),
);