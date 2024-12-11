import 'package:get/get.dart';
import 'package:tomatin/data/repository/register_repository.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<RegisterRepository>(() => RegisterRepository());
  }
}
