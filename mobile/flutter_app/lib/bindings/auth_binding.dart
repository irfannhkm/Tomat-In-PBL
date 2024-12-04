import 'package:get/get.dart';
import 'package:tomatin/controllers/auth_controller.dart';
import 'package:tomatin/data/repository/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(AuthRepository()));
  }
}
