import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tomatin/bloc/register/register_event.dart';
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/register_response.dart';

class RegisterRepository {
  final String baseUrl = Config.API_Url;

  Future<RegisterResponse> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    final url = Uri.parse('$baseUrl/v1/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'name': name,
          'email': email,
          'password': password,
          'c_password': cPassword,
        }),
      );

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
