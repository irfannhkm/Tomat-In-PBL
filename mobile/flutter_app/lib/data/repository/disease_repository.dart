import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tomatin/config.dart';
import 'package:tomatin/data/models/disease_response.dart';

class DiseaseRepository extends GetConnect {
  void onInit() {
    final localStorage = GetStorage();
    httpClient.baseUrl = Config.API_Url;

    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Authorization'] = 'Bearer ${localStorage.read('token')}';
      return request;
    });
  }

  Future<Response> getDisease(String class_idx) async {
    return await get(
      '/diseases/class/$class_idx',
      headers: {'Accept': 'application/json'},
    );
  }
}
