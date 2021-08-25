import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut(() => AddCompanyController(), fenix: true);
  }
}
