import 'package:egot_services/app/modules/AddCompany/providers/assurance_provider.dart';
import 'package:get/get.dart';

import 'package:egot_services/app/modules/AddCompany/controllers/assurance_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';

import '../controllers/add_company_controller.dart';

class AddCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssuranceController>(
      () => AssuranceController(),
    );
    Get.lazyPut<AddCompanyController>(
      () => AddCompanyController(),
    );
    Get.lazyPut<AssuranceController>(
      () => AssuranceController(),
    );
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.put<UserController>(UserController());
    Get.lazyPut(() => AssuranceProvider());
  }
}
