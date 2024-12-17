import 'package:tomatin/data/models/login_response.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final String? accessToken;
  final User? user;

  RegisterResponse({
    required this.success,
    required this.message,
    this.accessToken,
    this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      accessToken: json['data']?['access_token'],
      user: json['data']?['user'] != null
          ? User.fromJson(json['data']['user'])
          : null,
    );
  }
}
