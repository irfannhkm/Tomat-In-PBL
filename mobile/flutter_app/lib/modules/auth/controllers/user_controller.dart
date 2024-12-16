import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tomatin/data/models/user.dart';
import 'package:tomatin/data/repositories/auth_repository.dart';

import 'package:tomatin/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final box = GetStorage();

  UserController(this._userRepository, this._authRepository);

  var isLoading = false.obs;
  User? user;
  var errorMessage = ''.obs;

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final token = box.read('token');
      if (token == null) {
        errorMessage.value = "Token tidak ditemukan. Silakan login ulang.";
        return;
      }

      final response = await _userRepository.getUserData(token);

      if (response.success) {
        user = response.data;
        errorMessage.value = '';
      } else {
        errorMessage.value = response.message ?? "Unknown error occurred.";
        user = null;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserData({
    required String name,
    required String username,
    required String email,
  }) async {
    isLoading.value = true;
    try {
      final token = box.read('token');
      if (token == null) {
        errorMessage.value = "Token tidak ditemukan. Silakan login ulang.";
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
        return;
      }

      final response = await _userRepository.updateUserData(
        token: token,
        name: name,
        username: username,
        email: email,
      );

      if (response.success) {
        user = response.data;
        errorMessage.value = '';
        Get.snackbar(
          'Sukses',
          response.message ?? "Data berhasil diperbarui.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        errorMessage.value = response.message ?? "Gagal memperbarui data.";
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: $e";
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      final token = box.read('token');
      if (token == null) {
        errorMessage.value = "Token tidak ditemukan. Silakan login ulang.";
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
        return;
      }

      await _authRepository.logout(token);
      box.remove('token');
      Get.snackbar(
        'Sukses',
        'Logout berhasil.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = "Gagal logout: $e";
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
