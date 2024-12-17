import 'package:get/get.dart';
import 'package:tomatin/data/repositories/auth_repository.dart';
import 'package:tomatin/modules/auth/controllers/user_controller.dart';
import 'package:tomatin/data/repositories/user_repository.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(
        () => UserController(UserRepository(), AuthRepository()));
  }
}
