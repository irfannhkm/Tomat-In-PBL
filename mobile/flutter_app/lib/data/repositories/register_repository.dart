import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/utils/config.dart';
import 'package:tomatin/data/models/otp_response.dart';
import 'package:tomatin/data/models/register_response.dart';
import 'package:get/get.dart';

class RegisterRepository {
  final localStorage = GetStorage();
  final String baseUrl = Config.API_Url;

  // @override
  // void onInit() {

  //   httpClient.addRequestModifier<Object?>((request) {
  //     request.headers['Authorization'] = 'Bearer ${localStorage.read('token')}';
  //     return request;
  //   });
  // }

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
        final errorData = jsonDecode(response.body);
        return RegisterResponse.fromJson(responseJson);
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<RegisterResponse> otpRegister(String email) async {
    final url = Uri.parse('$baseUrl/v1/auth/otp/register/send');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login gagal');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<RegisterResponse> otpVerify(String otp, String email) async {
    final url = Uri.parse('$baseUrl/v1/auth/otp/verify');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': otp,
          'email': email,
        }),
      );

      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login gagal');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
