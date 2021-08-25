import 'package:get/get.dart';

import '../controllers/list_company_controller.dart';

class ListCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListCompanyController>(
      () => ListCompanyController(),
    );
  }
}
