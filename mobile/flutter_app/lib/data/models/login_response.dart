import 'user.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String? accessToken;
  final User? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.accessToken,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      accessToken: json['data']?['access_token'],
      user: json['data']?['user'] != null
          ? User.fromJson(json['data']['user'])
          : null,
    );
  }
}
