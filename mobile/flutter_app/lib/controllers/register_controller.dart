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
    try {
      final response = await registerRepository.register(
          username, name, email, password, cPassword);
      if (response.success) {
        successMessage.value = response.message;
      } else {
        errorMessage.value = response.message;
      }
    } catch (error) {
      errorMessage.value = 'Terjadi kesalahan';
    } finally {
      isLoading.value = false;
    }
  }
}
