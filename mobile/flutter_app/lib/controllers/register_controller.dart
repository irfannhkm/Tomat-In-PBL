import 'package:get/get.dart';
import 'package:tomatin/data/repository/register_repository.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;

  final RegisterRepository registerRepository;

  RegisterController({required this.registerRepository});

  Future<void> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      final response = await registerRepository.register(
          username, name, email, password, cPassword);

      if (response.success) {
        successMessage.value = response.message;
      } else {
        if (response.data != null && response.data!.isNotEmpty) {
          errorMessage.value = response.data!.values.join(', ');
        } else {
          errorMessage.value = response.message;
        }
      }
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/repository/register_repository.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  RegisterController();

  Future<void> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    isLoading.value = true;
    try {
      final RegisterRepository registerRepository =
          Get.find<RegisterRepository>();
      final response = await registerRepository.register(
          username, name, email, password, cPassword);
      if (response.success) {
        successMessage.value = response.message;
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = response.message;
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> otpRegister(String email) async {
    isLoading.value = true;
    try {
      final RegisterRepository registerRepository =
          Get.find<RegisterRepository>();
      final response = await registerRepository.otpRegister(email);
      if (response.success!) {
        successMessage.value = response.message!;
        Get.toNamed('/otp-register');
      } else {
        errorMessage.value = response.message!;
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> otpVerify(String otp, String email) async {
    isLoading.value = true;
    try {
      final RegisterRepository registerRepository =
          Get.find<RegisterRepository>();
      final response = await registerRepository.otpVerify(otp, email);
      if (response.success!) {
        successMessage.value = response.message!;
        return true;
      } else {
        errorMessage.value = response.message!;
        return false;
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
