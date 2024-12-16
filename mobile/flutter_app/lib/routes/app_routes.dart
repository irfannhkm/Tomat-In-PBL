import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/modules/bindings/auth_binding.dart';
import 'package:tomatin/modules/bindings/user_binding.dart';
import 'package:tomatin/middleware/auth_middleware.dart';
import 'package:tomatin/ui/article_screen.dart';
import 'package:tomatin/modules/bindings/detect_binding.dart';
import 'package:tomatin/modules/bindings/register_binding.dart';
import 'package:tomatin/ui/forgotpass_screen.dart';
import 'package:tomatin/ui/main_screen.dart';
import 'package:tomatin/ui/plantcollection_screen.dart';
import 'package:tomatin/ui/onboarding_screen.dart';
import 'package:tomatin/ui/plantdetail_screen.dart';
import 'package:tomatin/ui/reminder_setting.dart';
import 'package:tomatin/ui/login_screen.dart';
import 'package:tomatin/ui/profile_screen.dart';
import 'package:tomatin/ui/otp_screen.dart';
import 'package:tomatin/ui/scanresult_screen.dart';
import 'package:tomatin/ui/splash_screen.dart';
import 'package:tomatin/ui/weather_screen.dart';
import 'package:tomatin/ui/scan_screen.dart';
import '../ui/signup_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(
        name: '/login',
        page: () => const LoginScreen(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: '/signup',
      page: () => SignUpScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(name: '/otp-register', page: () => const OtpScreen()),
    GetPage(name: '/forgotpass', page: () => const ForgotpassScreen()),
    GetPage(name: '/home', page: () => const MainScreen()),
    GetPage(
        name: '/profile',
        page: () => const ProfileScreen(),
        binding: UserBinding()),
    GetPage(
        name: '/plantcollection', page: () => const PlantCollectionScreen()),
    GetPage(name: '/article', page: () => ArticleScreen()),
    GetPage(
        name: '/plantdetail',
        page: () =>
            const PlantDetailScreen(plantName: 'Tomat 1', status: 'Sehat')),
    GetPage(name: '/reminder', page: () => const ReminderSetting()),
    GetPage(name: '/weather', page: () => const WeatherScreen()),
    GetPage(
      name: '/scan',
      page: () => FutureBuilder(
        future: availableCameras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CameraDescription>? cameras = snapshot.data;
            return CameraScanScreen(
              camera: cameras!.first,
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    ),
    GetPage(
        name: '/scan-result',
        page: () => const ScanresultScreen(),
        binding: DetectBinding()),
    GetPage(
      name: '/article',
      page: () => const ArticleScreen(),
    ),
  ];
}
