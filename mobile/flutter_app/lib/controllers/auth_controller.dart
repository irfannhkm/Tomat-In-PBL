import 'package:get/get.dart';
import 'package:tomatin/data/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage("Email dan password tidak boleh kosong.");
      Get.snackbar("Error", errorMessage.value);
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authRepository.login(email, password);

      if (response.success!) {
        Get.snackbar('Login Success', 'Welcome back');
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = response.message!;
        Get.snackbar("Login Failed", response.message!);
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
