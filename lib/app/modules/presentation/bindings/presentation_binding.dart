import 'package:get/get.dart';

import '../controllers/presentation_controller.dart';

class PresentationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresentationController>(
      () => PresentationController(),
    );
  }
}
