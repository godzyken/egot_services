import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:egot_services/app/themes/app_theme_data.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_option.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'egot_services',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
    } catch (e) {
      log('Firebase error: $e');
    }
  }

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: "Egote Service App",
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
