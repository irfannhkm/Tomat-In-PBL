import 'package:get/get.dart';
import 'package:tomatin/controllers/user_controller.dart';
import 'package:tomatin/data/repository/user_repository.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(UserRepository()));
  }
}
