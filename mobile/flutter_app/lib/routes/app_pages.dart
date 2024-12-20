import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomatin/middleware/auth_middleware.dart';
import 'package:tomatin/modules/auth/binding/auth_binding.dart';
import 'package:tomatin/modules/detect/binding/detect_binding.dart';
import 'package:tomatin/modules/auth/binding/register_binding.dart';
import 'package:tomatin/modules/auth/binding/user_binding.dart';
import 'package:tomatin/modules/articles/views/article_screen.dart';
import 'package:tomatin/modules/auth/views/forgotpass_screen.dart';
import 'package:tomatin/modules/auth/views/login_screen.dart';
import 'package:tomatin/modules/home/views/main_screen.dart';
import 'package:tomatin/modules/auth/views/otp_screen.dart';
import 'package:tomatin/modules/plantcollection/views/historydetail_screen.dart';
import 'package:tomatin/modules/plantcollection/views/plantcollection_screen.dart';
import 'package:tomatin/modules/plantcollection/views/plantdetail_screen.dart';
import 'package:tomatin/modules/auth/views/profile_screen.dart';
import 'package:tomatin/modules/plantcollection/views/reminder_setting.dart';
import 'package:tomatin/modules/detect/views/scan_screen.dart';
import 'package:tomatin/modules/detect/views/scanresult_screen.dart';
import 'package:tomatin/modules/auth/views/signup_screen.dart';
import 'package:tomatin/ui/splash_screen.dart';
import 'package:tomatin/modules/home/views/onboarding_screen.dart';
import 'package:tomatin/ui/weather_screen.dart'; // Add this line

class AppPages {
  static const initial = '/';

  static final pages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
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
      binding: UserBinding(),
    ),
    GetPage(
      name: '/plantcollection',
      page: () => const PlantCollectionScreen(),
    ),
    GetPage(name: '/article', page: () => const ArticleScreen()),
    GetPage(
      name: '/plantdetail',
      page: () =>
          const PlantDetailScreen(plantName: 'Tomat 1', status: 'Sehat'),
    ),
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
      binding: DetectBinding(),
    ),
    GetPage(
      name: '/article',
      page: () => const ArticleScreen(),
    ),
    GetPage(
      name: '/historyDetail',
      page: () => HistoryDetailScreen(),
      binding: DetectBinding(),
    ),
  ];
}