import 'package:get/get.dart';

import '../controllers/atelier_controller.dart';

class AtelierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AtelierController>(
      () => AtelierController(),
    );
  }
}
