import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/detect_response.dart';

class DetectRepository extends GetConnect {
  void onInit() {
    final localStorage = GetStorage();
    httpClient.baseUrl = Config.API_Deteksi;

    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${localStorage.read('token')}';
      return request;
    });
  }

  Future<Response> detect(String file_path) async {
    final formData = FormData({
      'file': MultipartFile(file_path, filename: 'image.jpg'),
    });

    return await post(
      '/',
      formData,
      contentType: 'multipart/form-data',
      headers: {'Accept': 'application/json'},
    );
  }
}
