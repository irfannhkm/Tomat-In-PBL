import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotpassScreen extends StatelessWidget {
  const ForgotpassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF2A8F79)),
                      onPressed: () {
                        GoRouter.of(context).go(
                          '/login',
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF2A8F79)),
                      onPressed: () {
                        GoRouter.of(context).go(
                          '/login',
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Logo
              Image.asset(
                'assets/logo_only.png',
                height: 80,
              ),
              const SizedBox(height: 20),

              const Text(
                'Lupa Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'reset password',
                style: TextStyle(
                  color: Color(0xFF2A8F79),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2C2C34),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Color(0xFF5A5A62)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go(
                    '/home',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1AA283),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Kirim',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
