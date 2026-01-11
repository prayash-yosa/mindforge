import 'package:flutter/material.dart';
import 'package:mindforge_app/screens/dashboard/student_dashboard.dart';
import 'package:mindforge_app/screens/dashboard/teacher_dashboard.dart';
import 'package:mindforge_app/screens/dashboard/parent_dashboard.dart';
import 'package:mindforge_app/screens/login/role_selection_screen.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showEmailError = false;
  bool _showPasswordError = false;

  static const Color accentColor = Color(0xFF0A2F69);

  void _handleLogin() {
    setState(() {
      _showEmailError = _emailController.text.isEmpty;
      _showPasswordError = _passwordController.text.isEmpty;
    });

    if (!_showEmailError && !_showPasswordError) {
      final email = _emailController.text.toLowerCase();
    
      final detectedRole = _detectRoleFromEmail(email);
      
      if (detectedRole != null) {
        _navigateBasedOnRole(detectedRole);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RoleSelectionScreen(
              email: email,
            ),
          ),
        );
      }
    }
  }

  String? _detectRoleFromEmail(String email) {
    // Student patterns
    if (email.contains('student') || 
        email.endsWith('@student.mindforge.guru') ||
        email.endsWith('@student.mindforge.com') ||
        email.contains('@student.')) {
      return 'student';
    }
    
    // Teacher patterns
    else if (email.contains('teacher') || 
             email.endsWith('@teacher.mindforge.guru') ||
             email.endsWith('@teacher.mindforge.com') ||
             email.contains('@teacher.')) {
      return 'teacher';
    }
    
    // Parent patterns
    else if (email.contains('parent') || 
             email.endsWith('@parent.mindforge.guru') ||
             email.endsWith('@parent.mindforge.com') ||
             email.contains('@parent.')) {
      return 'parent';
    }
    
    // Generic patterns for testing
    else if (email.endsWith('@mindforge.guru')) {
      // Check prefix
      if (email.startsWith('teacher') || email.contains('.teacher')) {
        return 'teacher';
      } else if (email.startsWith('student') || email.contains('.student')) {
        return 'student';
      } else if (email.startsWith('parent') || email.contains('.parent')) {
        return 'parent';
      }
    }
    
    return null; 
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'student':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentDashboardScreen(),
          ),
        );
        break;
      case 'teacher':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherDashboardScreen(),
          ),
        );
        break;
      case 'parent':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ParentDashboardScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              accentColor.withOpacity(0.08),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/Mindforge-logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
               
                const SizedBox(height: 8),
                
                // Login Form Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login to MindForge",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Enter your credentials to continue",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Email Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "teacher@mindforge.guru",
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: accentColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          if (_showEmailError)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                'Please enter your email address',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 14),
                      
                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: accentColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          if (_showPasswordError)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                'Please enter your password',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 12,
                              color: accentColor,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 14),
                      
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 18),
                      
                      if (_showEmailError || _showPasswordError)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber,
                                size: 16,
                                color: Colors.red.shade600,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Please fill in all required fields',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Bottom text
                const SizedBox(height: 30),
                Text(
                  "Made with Love ❤️\nBy PJ",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}