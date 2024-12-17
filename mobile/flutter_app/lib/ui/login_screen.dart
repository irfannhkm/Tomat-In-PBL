import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tomatin/controllers/auth_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isPasswordVisible.dispose();
    super.dispose();
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: const Color(0xFFD01E26),
                rightDotColor: const Color(0xFF306526),
                size: 50,
              ),
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Obx(
          () {
            if (authController.isLoading.value) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: const Color(0xFFD01E26),
                  rightDotColor: const Color(0xFF306526),
                  size: 50,
                ),
              );
            }
            return Padding(
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
                            Get.toNamed('/onboarding');

                          },
                        ),
                        //tombol daftar
                        TextButton(
                          child: Text(
                            'Daftar',
                            style: TextStyle(color: Color(0xFF2A8F79)),
                          ),
                          onPressed: () {

                            Get.toNamed('/signup');

                          },
                        )
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
                  ValueListenableBuilder<bool>(
                    valueListenable: isPasswordVisible,
                    builder: (context, isVisible, child) {
                      return TextField(
                        controller: passwordController,
                        obscureText: isPasswordVisible.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF2C2C34),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Color(0xFF5A5A62)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              isPasswordVisible.value =
                                  !isPasswordVisible.value;
                            },
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {

                      Get.toNamed('/forgotpass');

                    },
                    child: const Text(
                      'Lupa password?',
                      style: TextStyle(color: Color(0xFF2A8F79)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () async {
                              await authController.login(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E5F56),
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
                            color: Color.fromRGBO(255, 255, 255,
                                0.8), // Adjust the opacity to your preference
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 20),
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
                          Get.toNamed('/signup');
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
            );
          },
        ),
      ),
    );
  }
}
