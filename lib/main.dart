import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:egot_services/app/themes/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'firebase_option.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetxFire.init(
    name: 'egot_services',
    options: firebaseOptions,
  );

  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: "Egote Service App",
    initialBinding: BindingsBuilder(() => Get.put(AuthController())),
    getPages: AppPages.routes,
    routingCallback: (value) => Get.toNamed('/', id: Get.arguments['id']),
    opaqueRoute: Get.isOpaqueRouteDefault,
    popGesture: Get.isPopGestureEnable,
    transitionDuration: Get.defaultDialogTransitionDuration,
    locale: Get.locale,
    defaultTransition: Transition.fade,
    enableLog: true,
    themeMode: AppThemeData.INITIAL,
  ));
}
