import 'package:get/get.dart';

import '../controllers/ouvrage_controller.dart';

class OuvrageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OuvrageController>(
      () => OuvrageController(),
    );
  }
}
