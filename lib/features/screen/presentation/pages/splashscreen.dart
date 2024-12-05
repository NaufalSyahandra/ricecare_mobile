import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/auth/presentation/pages/signin_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  void navigateToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide transition effect (slide up)
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1), // Start from bottom
                end: Offset.zero, // End at normal position (top)
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, // Smooth animation curve
              )),
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1), // Duration of slide animation
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
    _timer = Timer(const Duration(seconds: 3), navigateToLogin);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15B392),
      body: Center(
        child: GestureDetector(
          onTap: navigateToLogin,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
