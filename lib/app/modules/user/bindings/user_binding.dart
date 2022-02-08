import 'package:get/get.dart';

import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/modules/user/providers/user_provider.dart';

import '../controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(
      () => UserController(Get.parameters['userId'] ?? ''),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<RegisterServices>(
      () => RegisterServices(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
  }
}
