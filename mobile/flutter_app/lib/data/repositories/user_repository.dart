import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tomatin/utils/config.dart';
import 'package:tomatin/data/models/api_response.dart';
import 'package:tomatin/data/models/user.dart';

class UserRepository {
  final String baseUrl = Config.API_Url;

  Future<ApiResponse<User>> getUserData(String token) async {
    final url = Uri.parse("$baseUrl/v1/user");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse<User>.fromJson(
          jsonDecode(response.body),
          (data) => User.fromJson(data),
        );
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized access.");
      } else {
        throw Exception("Gagal mendapatkan data user");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<ApiResponse<User>> updateUserData({
    required String token,
    required String name,
    required String username,
    required String email,
  }) async {
    final url = Uri.parse("$baseUrl/v1/user");

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'username': username,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse<User>.fromJson(
          jsonDecode(response.body),
          (data) => User.fromJson(data),
        );
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized access.");
      } else {
        throw Exception("Failed to update user data.");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
  
}
