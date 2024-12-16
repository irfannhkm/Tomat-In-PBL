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

  Future<void> register() async {
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
          username, name, email, password, cPassword,
        );

        if (response.success) {
          successMessage.value = response.message;
          Get.offAllNamed('/home');
        } else {
          errorMessage.value = _parseErrorResponse(response);
        }
      } catch (error) {
        errorMessage.value = error.toString();
      } finally {
        isLoading.value = false;
      }
    }
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

  String _parseErrorResponse(RegisterResponse response) {
    if (response.data != null && response.data!.isNotEmpty) {
      return response.data!.values.join(', ');
    }
    return response.message;
  }

  Future<void> otpRegister(String email) async {
    await _handleApiCall(
      apiCall: () => registerRepository.otpRegister(email),
      onSuccess: (response) {
        successMessage.value = response.message;
        Get.toNamed('/otp-register');
      },
    );
  }

  Future<bool> otpVerify(String otp, String email) async {
    bool result = false;
    await _handleApiCall(
      apiCall: () => registerRepository.otpVerify(otp, email),
      onSuccess: (response) {
        successMessage.value = response.message;
        result = true;
      },
    );
    return result;
  }

  Future<void> _handleApiCall({
    required Future<RegisterResponse> Function() apiCall,
    required Function(RegisterResponse) onSuccess,
    String loadingMessage = "Loading...",
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await apiCall();
      if (response.success) {
        onSuccess(response);
      } else {
        errorMessage.value =
            response.data?.values.join(', ') ?? response.message;
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
