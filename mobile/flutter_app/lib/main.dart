import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatin/bloc/auth/auth_bloc.dart';
import 'package:tomatin/bloc/register/register_bloc.dart';
import 'package:tomatin/data/repository/auth_repository.dart';
import 'package:tomatin/data/repository/register_repository.dart';
import 'package:tomatin/pages/article_screen.dart';
import 'package:tomatin/pages/main_screen.dart';
import 'package:tomatin/pages/onboarding_screen.dart';
import 'package:tomatin/pages/scan_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatin/pages/reminder_setting.dart';
import 'package:tomatin/ui/login_screen.dart';
import 'package:tomatin/ui/signup_screen.dart';

List<CameraDescription> _cameras = <CameraDescription>[];

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) =>
              RegisterBloc(registerRepository: RegisterRepository()),
        )
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
            path: '/scan',
            builder: (BuildContext context, GoRouterState state) {
              return MaterialApp(
                title: 'Camera Scanner',
                theme: ThemeData.dark(),
                home: CameraScanScreen(camera: _cameras.first),
              );
            }),
        GoRoute(
          path: '/article',
          builder: (BuildContext context, GoRouterState state) {
            return const ArticleScreen();
          },
        ),
      ],
    ),
  ],
);
