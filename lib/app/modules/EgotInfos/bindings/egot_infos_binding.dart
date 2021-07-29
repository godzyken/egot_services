import 'package:get/get.dart';

import '../controllers/egot_infos_controller.dart';

class EgotInfosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EgotInfosController>(
      () => EgotInfosController(),
    );
  }
}
