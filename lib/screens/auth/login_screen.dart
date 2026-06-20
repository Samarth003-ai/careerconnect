import 'package:flutter/material.dart';
import 'package:resume_builder/core/services/auth_service.dart';
import 'package:resume_builder/core/services/token_service.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Login to continue"),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,

                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(labelText: "Password"),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () async {
                    final result = await AuthService().login(
                      emailController.text,
                      passwordController.text,
                    );

                    if (result["success"]) {
                      await TokenService().saveToken(result["token"]);

                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).setToken(result["token"]);

                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                      );
                    }
                  },

                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
