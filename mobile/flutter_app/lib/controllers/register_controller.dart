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
