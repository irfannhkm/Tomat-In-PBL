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
    if (!GetUtils.isEmail(email)) {
      errorMessage.value = 'Email tidak valid';
      Get.snackbar("Error", errorMessage.value);
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authRepository.login(email, password);

      if (response.success!) {
        Get.snackbar('Login Berhasil', 'Selamat Datang!');
        Get.offAllNamed('/home');
        Get.snackbar("Login Success", "Welcome ${response.data!.user.name}");
      } else {
        errorMessage.value = response.message!;
        Get.snackbar("Login Gagal", response.message!);
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
