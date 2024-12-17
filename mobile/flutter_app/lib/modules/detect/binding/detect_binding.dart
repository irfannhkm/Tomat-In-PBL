import 'package:get/get.dart';
import 'package:tomatin/modules/detect/controllers/detect_controller.dart';

class DetectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetectController>(() => DetectController());
  }
  
}