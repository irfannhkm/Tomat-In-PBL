import 'package:tomatin/data/models/login_data.dart';

class LoginResponse {
  final bool success;
  final LoginData? data;
  final String message;

  LoginResponse({
    required this.success,
    this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}
