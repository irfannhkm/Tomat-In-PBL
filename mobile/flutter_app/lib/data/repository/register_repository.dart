import 'dart:convert';
import 'package:http/http.dart' as http;
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

      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(responseJson);
      } else {
        return RegisterResponse.fromJson(responseJson);
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
