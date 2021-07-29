import 'package:get/get.dart';

import '../controllers/sketch_my_wishes_controller.dart';

class SketchMyWishesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SketchMyWishesController>(
      () => SketchMyWishesController(),
    );
  }
}
