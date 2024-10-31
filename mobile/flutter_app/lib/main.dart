import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_screen.dart';
import 'package:flutter_app/pages/main_screen.dart';
import 'package:flutter_app/pages/onboarding_screen.dart';
import 'package:flutter_app/pages/scan_screen.dart';
import 'package:flutter_app/pages/signup_screen.dart';
// import 'package:flutter_app/pages/scan_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/pages/reminder_setting.dart';
// import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> _cameras = <CameraDescription>[];

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    _logError(e.code, e.description);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
        ),
        GoRoute(
          path: '/reminder',
          builder: (BuildContext context, GoRouterState state) {
            return ReminderSetting(); // Halaman pengingat
          },
        ),
        GoRoute(path: '/scan', builder: (BuildContext context, GoRouterState state) {
          return MaterialApp(
            title: 'Camera Scanner',
            theme: ThemeData.dark(),
            home: CameraScanScreen(camera: _cameras.last),
          );
        }),
      ],
    ),
  ],
);
