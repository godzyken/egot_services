import 'package:get/get.dart';

import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/AddCompany/providers/assurance_provider.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:egot_services/app/modules/user/providers/user_provider.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AddCompanyController>(() => AddCompanyController(),
        fenix: true);
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserController>(() => UserController(Get.parameters['userId'] ?? ''));
    Get.lazyPut<AssuranceProvider>(() => AssuranceProvider());
    Get.lazyPut<RegisterServices>(() => RegisterServices(), fenix: true);
  }
}
