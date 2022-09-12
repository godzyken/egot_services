import 'package:egot_services/app/models/use_x_models.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AvatarBodyController extends GetxController {
  final userModel = UserModel().obs;

  final count = 0.obs;
  @override
  void onInit() {
    update();
    super.onInit();
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
