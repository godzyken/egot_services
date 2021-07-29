import 'package:get/get.dart';

import '../controllers/mentions_legals_controller.dart';

class MentionsLegalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MentionsLegalsController>(
      () => MentionsLegalsController(),
    );
  }
}
