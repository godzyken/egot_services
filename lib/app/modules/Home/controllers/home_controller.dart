import 'package:egot_services/app/models/menus_model.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var menuList = menus.obs;
  var selectedMenu = 0.obs;
  var scrollController = ScrollController();
  var h = Get.mediaQuery.size.height;
  var w = Get.mediaQuery.size.width;
  var isSignIn = false.obs;

  var firebaseAuthController = SignInController();

  @override
  void onInit() {
    super.onInit();
    firebaseAuthController.refresh();
    isSignIn.value = AuthController().isSignIn.value;
  }

  @override
  void onReady() {
    isSignIn.value = AuthController().isSignIn.value;
    firebaseAuthController.firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    super.onReady();
  }

  @override
  void onClose() {
    print('>>> HomeController close');
    super.onClose();
  }
}
