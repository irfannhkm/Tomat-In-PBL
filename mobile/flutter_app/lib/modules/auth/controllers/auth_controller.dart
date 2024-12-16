import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomatin/data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final box = GetStorage();

  AuthController(this._authRepository);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage("Email dan password tidak boleh kosong.");
      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (!GetUtils.isEmail(email)) {
      errorMessage.value = 'Email tidak valid';
      Get.snackbar("Error", errorMessage.value);
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authRepository.login(email, password);

      if (response.success != null &&
          response.success! &&
          response.data != null) {
        box.write('token', response.data!.token);
        errorMessage.value = '';
        Get.offAllNamed('/home');
        Get.snackbar(
          "Login Success",
          "Welcome ${response.data!.user?.name}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        errorMessage.value = response.message!;
        Get.snackbar(
          "Login Gagal",
          response.message!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
      Get.snackbar(
        "Error",
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar(
          "Google Sign-In",
          "Login cancelled by user",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final response = await _authRepository.googleSignIn(googleUser.id);

      if (response.success != null && response.success!) {
        box.write('token', response.data);
        Get.offAllNamed('/home');
        Get.snackbar(
          "Login Success",
          "Welcome ${googleUser.displayName}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Google Sign-In Failed",
          response.message ?? 'Unknown error',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      errorMessage.value = 'Google Sign-In failed';
      Get.snackbar(
        "Error",
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? getToken() {
    return box.read('token');
  }

  Future<void> logout() async {
    try {
      final token = getToken();
      if (token != null) {
        await _authRepository.logout(token);
      }
      box.remove('token');
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Logout',
        'Gagal logout: $e, coba lagi nanti.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
