import 'package:get/get.dart';

import '../controllers/company_card_controller.dart';

class CompanyCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyCardController>(
      () => CompanyCardController(),
    );
  }
}
