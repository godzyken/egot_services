import 'package:get/get.dart';

import '../controllers/godzy_logo_controller.dart';

class GodzyLogoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GodzyLogoController>(
      () => GodzyLogoController(),
    );
  }
}
