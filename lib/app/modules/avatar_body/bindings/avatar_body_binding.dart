import 'package:get/get.dart';

import '../controllers/avatar_body_controller.dart';

class AvatarBodyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvatarBodyController>(
      () => AvatarBodyController(),
    );
  }
}
