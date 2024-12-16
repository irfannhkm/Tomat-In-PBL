import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomatin/data/repository/auth_repository.dart';

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

      if (response.success && response.data != null) {
        box.write('token', response.data!.token);
        errorMessage.value = '';
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

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar("Google Sign-In", "Login cancelled by user");
        return;
      }

      final response = await _authRepository.googleSignIn(googleUser.id);

      if (response.success) {
        box.write('token', response.data);
        Get.offAllNamed('/home');
        Get.snackbar("Login Success", "Welcome ${googleUser.displayName}");
      } else {
        Get.snackbar("Google Sign-In Failed", response.message);
      }
    } catch (error) {
      errorMessage.value = 'Google Sign-In failed';
      Get.snackbar("Error", error.toString());
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
      Get.snackbar('Logout', 'Gagal logout: $e, coba lagi nanti.');
    }
  }
}
