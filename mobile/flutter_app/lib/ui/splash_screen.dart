import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Durasi SplashScreen
    Get.offAllNamed('/onboarding'); // Arahkan ke OnboardingScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            const Color(0xFF191d26), // Sesuaikan dengan warna aplikasi
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash_screen.png',
                height: 350,
              ),
              const SizedBox(height: 20),
              // LoadingAnimationWidget.discreteCircle(
              //     color: Colors.white,
              //     size: 20,
              //     secondRingColor: Color(0xFFD01E26),
              //     thirdRingColor: Color(0xFF306526)),
              LoadingAnimationWidget.flickr(
                  leftDotColor: const Color(0xFFD01E26),
                  rightDotColor: const Color(0xFF306526),
                  size: 25)
            ],
          ),
        )));
  }
}
