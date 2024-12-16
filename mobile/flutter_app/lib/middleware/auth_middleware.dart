import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final token = GetStorage().read('token');
    if (token != null && route == '/login') {
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}
