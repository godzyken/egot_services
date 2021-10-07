import 'package:egot_services/app/models/menus_model.dart';
import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var menuList = menus.obs;
  var selectedMenu = 0.obs;
  var menu = <Menu>[].obs;
  var scrollController = ScrollController();
  var h = Get.mediaQuery.size.height;
  var w = Get.mediaQuery.size.width;

  var isSignIn = false.obs;

  var firebaseAuthController = SignInController();

  UserModel? userModel;

  @override
  void onInit() {
    print('>>> HomeController init');
    userModel = RegisterController().userModel.value;

    super.onInit();
  }

  @override
  void onReady() {
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = firebaseAuthController.firebaseAuth.currentUser != null;
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

  void handleAuthStateChanged(isSignIn) {
    if (isSignIn) {
      Get.offAllNamed(Routes.HOME, arguments: firebaseAuthController.firebaseAuth.currentUser);
    } else {
      Get.offAllNamed(Routes.REGISTER);
    }
  }

}
