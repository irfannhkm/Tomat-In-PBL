import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/data/models/otp_response.dart';
import 'package:tomatin/utils/config.dart';
import 'package:tomatin/data/models/register_response.dart';

class RegisterRepository extends GetConnect {
  final String baseUrl = Config.API_Url;

  @override
  void onInit() {
    final localStorage = GetStorage();

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
        throw Exception('Registrasi gagal');
      }
    } catch (e) {
      throw Exception('Registrasi gagal: $e');
    }
  }

  Future<OtpResponse> otpRegister(String email) async {
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
        return otpResponseFromJson(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal mengirim OTP');
      }
    } catch (e) {
      throw Exception('Gagal mengirim OTP: $e');
    }
  }

  Future<OtpResponse> otpVerify(String otp, String email) async {
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

      if (response.statusCode == 200) {
        return otpResponseFromJson(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Verifikasi OTP gagal');
      }
    } catch (e) {
      throw Exception('Verifikasi OTP gagal: $e');
    }
  }
}
