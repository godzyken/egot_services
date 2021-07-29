import 'package:get/get.dart';

import '../controllers/egot_services_controller.dart';

class EgotServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EgotServicesController>(
      () => EgotServicesController(),
    );
  }
}
