import 'package:get/get.dart';

import '../controllers/archives_controller.dart';

class ArchivesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchivesController>(
      () => ArchivesController(),
    );
  }
}
