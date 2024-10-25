import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_screen.dart';
import 'package:flutter_app/pages/main_screen.dart';
import 'package:flutter_app/pages/signup_screen.dart';
import 'package:go_router/go_router.dart';

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
      path: '/',  // Rute utama (LoginScreen)
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signup',  // Rute untuk halaman SignUpScreen
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: 'home',  // Rute untuk halaman MainScreen
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
        ),
      ],
    ),
  ],
);
