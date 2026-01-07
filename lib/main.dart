import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/splash/splash_screen.dart';


void main() {
  runApp(const MindforgeApp());
}

class MindforgeApp extends StatelessWidget {
  const MindforgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mindforge',
      theme: MindforgeTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
