import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF2A8F79)),
                      onPressed: () {},
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
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Pilih opsi untuk masuk',
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

              const SizedBox(height: 20),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2C2C34),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Color(0xFF5A5A62)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon:
                      const Icon(Icons.remove_red_eye, color: Colors.grey),
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
                    'Masuk',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: <Widget>[
                  Expanded(child: Divider(color: Colors.grey[700])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "atau lanjutkan dengan",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[700])),
                ],
              ),

              const SizedBox(height: 20),

              // Google login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 145.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey, width: 1),
                    backgroundColor: const Color(0xFF2C2C33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/google_logo.png',
                      height: 24,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go(
                        '/signup',
                      );
                    },
                    child: const Text(
                      'Buat akun',
                      style: TextStyle(color: Color(0xFF2A8F79)),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
