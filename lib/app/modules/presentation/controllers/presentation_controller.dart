import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class PresentationController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  late User? user;

  @override
  void onInit() {
    user = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void logout() async {
    await homeController.firebaseAuth.signOut();
  }
}
