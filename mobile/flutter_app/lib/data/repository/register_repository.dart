import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/otp_response.dart';
import 'package:tomatin/data/models/register_response.dart';
import 'package:get/get.dart';

class RegisterRepository extends GetConnect {
  @override
  void onInit() {
    final localStorage = GetStorage();
    httpClient.baseUrl = Config.API_Url;

    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${localStorage.read('token')}';
      return request;
    });
  }

  Future<RegisterResponse> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    final url = '/v1/auth/register';

    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        {
          'username': username,
          'name': name,
          'email': email,
          'password': password,
          'c_password': cPassword,
        },
      );

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login gagal');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<OtpResponse> otpRegister(
    String email,
  ) async {
    final url = '/v1/auth/otp/register/send';
  Future<RegisterResponse> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    final url = Uri.parse('$baseUrl/v1/auth/register');

    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return otpResponseFromJson(response.bodyString!);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login gagal');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<OtpResponse> otpVerify(String otp, String email) async {
    final url = '/v1/auth/otp/verify';

    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        {
          'otp': otp,
          'email': email,
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
        return otpResponseFromJson(response.bodyString!);
        return RegisterResponse.fromJson(responseJson);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login gagal');
        return RegisterResponse.fromJson(responseJson);
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
