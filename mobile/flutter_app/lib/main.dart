import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatin/bloc/auth/auth_bloc.dart';
import 'package:tomatin/data/repository/auth_repository.dart';
import 'package:tomatin/pages/forgotpass_screen.dart';
import 'package:tomatin/pages/main_screen.dart';
import 'package:tomatin/pages/onboarding_screen.dart';
import 'package:tomatin/pages/plantdetail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatin/pages/reminder_setting.dart';
import 'package:tomatin/pages/scan_screen.dart';
import 'package:tomatin/ui/login_screen.dart';
import 'package:tomatin/ui/signup_screen.dart';
import 'package:tomatin/ui/weather_screen.dart';

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
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
            return LoginScreen();
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
        GoRoute(
          path: '/plantdetail',
          builder: (BuildContext context, GoRouterState state) {
            return PlantDetailScreen(plantName: 'Tomat 1', status: 'Sehat');
          },
        ),
        GoRoute(
          path: '/forgotpassword',
          builder: (BuildContext context, GoRouterState state) {
            return const ForgotpassScreen();
          },
        ),
        GoRoute(
          path: '/scan',
          builder: (BuildContext context, GoRouterState state) {
            return FutureBuilder(
              future: availableCameras(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CameraDescription>? cameras = snapshot.data;
                  return MaterialApp(
                    title: 'Camera Scanner',
                    theme: ThemeData.dark(),
                    home: CameraScanScreen(
                        camera: cameras!
                            .first), // Use the null-aware operator (`?.`) to handle the case when `cameras` is null
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          },
        ),
        GoRoute(
          path: '/weather',
          builder: (BuildContext context, GoRouterState state) {
            return const WeatherScreen();
          },
        ),
      ],
    ),
  ],
);
