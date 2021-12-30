import 'package:get/get.dart';

import 'package:egot_services/app/models/assurance_model.dart';
import 'package:egot_services/app/modules/AddCompany/providers/assurance_provider.dart';

class AssuranceController extends GetxController
    with StateMixin<List<Assurance>> {
  static AssuranceController? get to => Get.find();
  final provider = AssuranceProvider();

  final assurance = Assurance().obs;

  @override
  void onInit() {
    fetchList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // void increment() => count.value++;

  void fetchList() async {
    final Response res = await provider.getAllAssurance();
    if (res.hasError) {
      change(null, status: RxStatus.error(res.statusText));
    } else {
      change(res.body, status: RxStatus.success());
      // count.value++;
    }
  }
}
