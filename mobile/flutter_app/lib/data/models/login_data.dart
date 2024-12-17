import 'package:tomatin/data/models/user.dart';

class LoginData {
  final String token;
  final User user;

  LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
