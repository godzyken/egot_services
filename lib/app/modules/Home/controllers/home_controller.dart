import 'package:egot_services/app/models/menus_model.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var isLoading = true.obs;
  var menuList = <Menu>[].obs;
  int selectedMenu = 0;

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
      Get.offAllNamed(Routes.PRESENTATION, arguments: firebaseAuth.currentUser);
    } else {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

}
