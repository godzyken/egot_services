import 'package:egot_services/app/models/menus_model.dart';
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

  late final googleSign;
  var isSignIn = false.obs;

  FirebaseAuth firebaseAuth = GetxFire.auth;

  @override
  void onInit() {
    print('>>> HomeController init');

    super.onInit();
  }

  @override
  void onReady() async {
    googleSign = GetxFire.signInWithGoogle();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
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
      Get.offAllNamed(Routes.HOME, arguments: firebaseAuth.currentUser);
    } else {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  isSelected() async {

  }

}
