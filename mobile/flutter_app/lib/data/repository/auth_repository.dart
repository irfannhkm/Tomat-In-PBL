import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/login_response.dart';

class AuthRepository {
  final String baseUrl = Config.API_Url;

  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/v1/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        GetStorage().write('token', loginResponse.data?.token);
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('email atau password Anda salah');
      } else if (response.statusCode >= 500) {
        throw Exception("Server sedang bermasalah, coba lagi nanti.");
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
    throw Exception('Unexpected error occurred');
  }

  Future<LoginResponse> googleSignIn(String googleId) async {
    final url = Uri.parse('$baseUrl/v1/auth/google/callback');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'google_id': googleId,
        }),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to sign in with Google');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<void> logout(String token) async {
    final url = Uri.parse('$baseUrl/v1/auth/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }
}
