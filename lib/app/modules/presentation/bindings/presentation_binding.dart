import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:egot_services/app/modules/presentation/providers/presentation_provider.dart';
import 'package:egot_services/app/modules/presentation/repository/repository.dart';
import 'package:get/get.dart';

import '../controllers/presentation_controller.dart';

class PresentationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<IPresentationProvider>(() => PresentationProvider());
    Get.lazyPut<IStoreRepository>(() => StoreRepository(provider: Get.find()));
    Get.put(PresentationController(repository: Get.find()));
    Get.lazyPut(() => PresentationController(repository: Get.find()));
  }
}
