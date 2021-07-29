import 'package:get/get.dart';

import '../controllers/devis_controller.dart';

class DevisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevisController>(
      () => DevisController(),
    );
  }
}
