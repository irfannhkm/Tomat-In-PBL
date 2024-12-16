import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tomatin/data/models/user.dart';

import 'package:tomatin/data/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository;
  final box = GetStorage();

  UserController(this._userRepository);

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
      );
    } else {
      errorMessage.value = response.message ?? "Gagal memperbarui data.";
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    errorMessage.value = "Terjadi kesalahan: $e";
    Get.snackbar(
      'Error',
      errorMessage.value,
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    isLoading.value = false;
  }
}


  void logout() {
    box.remove('token');
    Get.offAllNamed('/login');
  }
}
