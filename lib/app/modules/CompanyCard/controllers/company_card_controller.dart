import 'package:get/get.dart';

import 'package:egot_services/app/models/use_x_models.dart';

class CompanyCardController extends GetxController {
  late final String? uid;
  final userModel = UserModel().obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
