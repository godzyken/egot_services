import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class RegisterController extends GetxController {
  var formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool success = false;
  String? userEmail;

  final userModel = UserModel().obs;

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

  void createNewUser() async {
    try {
      final fbCompany = Get.find<AddCompanyController>();
      var _user = UserModel(
        id: fbCompany.userModel.value.id,
        email: emailController,
        companyName: fbCompany.companyNameController,
        activity: fbCompany.activityController,
        matriculation: fbCompany.matriculationController,
        length: fbCompany.lengthController,
        location: fbCompany.locationController,
        status: fbCompany.statusController,
        assurance: fbCompany.assuranceController,
        specialisation: fbCompany.specialisationController,
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
