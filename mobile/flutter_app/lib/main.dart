import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_screen.dart';
import 'package:flutter_app/pages/main_screen.dart';
import 'package:flutter_app/pages/signup_screen.dart';
import 'package:flutter_app/pages/scan_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/pages/reminder_setting.dart';

void main(List<String> args) {
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
        return const LoginScreen();
      },
      routes: <RouteBase>[
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
      ],
    ),
  ],
);
