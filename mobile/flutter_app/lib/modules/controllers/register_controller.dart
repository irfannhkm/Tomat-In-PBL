import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/models/register_response.dart';
import 'package:tomatin/data/repositories/register_repository.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;

  final RegisterRepository registerRepository;

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  RegisterController({required this.registerRepository});

  @override
  void onClose() {
    usernameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.onClose();
  }

  Future<void> register(
    String username,
    String name,
    String email,
    String password,
    String cPassword,
  ) async {
    if (_validateInputs()) {
      isLoading.value = true;
      errorMessage.value = '';

      final username = usernameController.text.trim();
      final name = fullNameController.text;
      final email = emailController.text;
      final password = passwordController.text;
      final cPassword = cPasswordController.text;

      try {
        final response = await registerRepository.register(
          username,
          name,
          email,
          password,
          cPassword,
        );

        if (response.success) {
          successMessage.value = response.message;
          Get.offAllNamed('/login');
        } else {
          errorMessage.value = response.message;
        }
      } catch (error) {
        errorMessage.value = error.toString();
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> sendOtpRequest(String email) async {
    isLoading.value = true;
    try {
      final response = await registerRepository.otpRegister(email);
      if (response.success!) {
        successMessage.value = response.message!;
        Get.toNamed('/otp-register');
      } else {
        errorMessage.value = response.message!;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> otpVerify(String otp, String email) async {
    bool result = false;
    isLoading.value = true;
    try {
      final response = await registerRepository.otpVerify(otp, email);
      if (response.success!) {
        successMessage.value = response.message!;
        result = true;
      } else {
        errorMessage.value = response.message!;
        result = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      result = false;
    } finally {
      isLoading.value = false;
    }
    return result;
  }

  bool _validateInputs() {
    if (usernameController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        cPasswordController.text.isEmpty) {
      errorMessage.value = 'Semua field harus diisi.';
      return false;
    }

    if (passwordController.text != cPasswordController.text) {
      errorMessage.value = 'Password dan konfirmasi password tidak cocok.';
      return false;
    }
    return true;
  }
}
