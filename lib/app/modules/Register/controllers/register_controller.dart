import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class RegisterController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final activityController = TextEditingController();
  final matriculationController = TextEditingController();
  final lengthController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final statusController = TextEditingController();
  final assuranceController = TextEditingController();
  final specialisationController = TextEditingController();
  bool success = false;
  String? userEmail;

  final userModel = UserModel();

  var isSignIn = false.obs;
  var firebaseAuthController = SignInController();

  @override
  void onInit() {
    print('>>> RegisterController init');

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> register() async {
    await GetxFire.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        isSuccessDialog: true,
        onSuccess: (userCredential) {
          if (userCredential!.user != null) {
            success = true;
            userEmail = userCredential.user!.email;
          } else {
            success = false;
          }
        },
        onError: (code, message) {
          GetxFire.openDialog.messageError(message!);
        });
  }

  void createNewUser(String? email, String? companyName) async {
    try {
      var _authResult = await firebaseAuthController.firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text);

      var _user = UserModel(
        id: _authResult.user!.uid,
        email: email,
        companyName: companyName,
        activity: activityController,
        matriculation: matriculationController,
        length: lengthController,
        location: locationController,
        status: statusController,
        assurance: assuranceController,
        specialisation: specialisationController,
      );
      if (await RegisterServices().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
