import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.of(context).pushReplacementNamed('/');
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Image.asset(
                  "assets/images/google-contacts-logo-A07A806C3B-seeklogo.com.png",
                  height: 180,
                  width: 180,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Contact App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 350),
                const Text(
                  "Made in India with ❤️",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0078FB),
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
