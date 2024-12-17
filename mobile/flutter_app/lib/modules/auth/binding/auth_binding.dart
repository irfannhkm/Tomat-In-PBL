import 'package:get/get.dart';
import 'package:tomatin/modules/auth/controllers/auth_controller.dart';
import 'package:tomatin/data/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(AuthRepository()));
  }
}
