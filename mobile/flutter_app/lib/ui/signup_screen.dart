import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/controllers/register_controller.dart';
import 'package:tomatin/data/repository/register_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RegisterController registerController = Get.put(RegisterController(registerRepository: RegisterRepository()));

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }

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
                        Get.back();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF2A8F79)),
                      onPressed: () {
                        Get.offAllNamed('/');
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
              Image.asset(
                'assets/logo_only.png',
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Daftar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Buat akun baru',
                style: TextStyle(
                  color: Color(0xFF2A8F79),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2C2C34),
                  hintText: 'Nama Pengguna',
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
                controller: fullNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2C2C34),
                  hintText: 'Nama Lengkap',
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
                controller: emailController,
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
                controller: passwordController,
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
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2C2C34),
                  hintText: 'Konfirmasi Password',
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
                  final username = usernameController.text;
                  final fullName = fullNameController.text;
                  final email = emailController.text;
                  final password = passwordController.text;
                  final cPassword = cPasswordController.text;

                  registerController.register(
                    username,
                    fullName,
                    email,
                    password,
                    cPassword,
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
                    'Daftar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xFF2A8F79)),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Obx(() {
                if (registerController.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                if (registerController.successMessage.isNotEmpty) {
                  Future.delayed(
                      Duration.zero,
                      () => Get.snackbar(
                          'Success', registerController.successMessage.value));
                }
                if (registerController.errorMessage.isNotEmpty) {
                  Future.delayed(
                      Duration.zero,
                      () => Get.snackbar(
                          'Error', registerController.errorMessage.value));
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
