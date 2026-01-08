import 'package:flutter/material.dart';
import 'package:mindforge_app/screens/login/student_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StudentLoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDF6), 
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1500),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.7 + (value * 0.3),
                child: child,
              ),
            );
          },
          child: Container(
            width: 260, 
            height: 260,
            child: Image.asset(
              'assets/images/Mindforge-logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}