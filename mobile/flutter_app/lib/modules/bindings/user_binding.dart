import 'package:get/get.dart';
import 'package:tomatin/modules/controllers/user_controller.dart';
import 'package:tomatin/data/repositories/user_repository.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(UserRepository()));
  }
}
