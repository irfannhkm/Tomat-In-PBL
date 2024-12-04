import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/bindings/auth_binding.dart';
import 'package:tomatin/routes/app_routes.dart';

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
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
    );
  }
}
