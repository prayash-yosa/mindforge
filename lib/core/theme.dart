import 'package:flutter/material.dart';

class MindforgeTheme {
  static const Color accentColor = Color(0xFF0A2F69); // Your accent color
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: accentColor, // Use accent color here
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: accentColor,
        letterSpacing: -0.3,
      ),
    ),
  );
}