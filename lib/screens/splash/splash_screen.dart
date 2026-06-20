import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resume_builder/screens/auth/login_screen.dart';
import '../../core/services/token_service.dart';

import '../auth/login_screen.dart';

import '../dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Future<void> checkLoginStatus() async {
    final token = await TokenService().getToken();

    await Future.delayed(
      //to make the splash screen visible
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void initState() {
    super.initState();

    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.work, size: 80),

            SizedBox(height: 20),

            Text(
              "CareerConnect",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
