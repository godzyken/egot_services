import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/add_company_controller.dart';

class AddCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCompanyController>(
      () => AddCompanyController(),
    );
    Get.put<RegisterController>(RegisterController());
    Get.put<UserController>(UserController());
  }
}
