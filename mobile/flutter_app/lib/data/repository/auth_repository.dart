import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tomatin/data/models/login_response.dart';

class AuthRepository {
  final String baseUrl = 'http://127.0.0.1/api';

  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

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
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
