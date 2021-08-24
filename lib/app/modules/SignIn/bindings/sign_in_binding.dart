import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(
      SignInController(),
    );

    Get.put<UserController>(UserController());
  }
}
