import 'package:get/get.dart';
import 'package:tomatin/data/repositories/register_repository.dart';
import 'package:tomatin/modules/auth/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
        () => RegisterController(registerRepository: RegisterRepository()));
  }
}
