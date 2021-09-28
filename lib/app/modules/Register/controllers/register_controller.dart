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
  static RegisterController? get to => Get.find();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  bool success = false;
  String? userEmail;

  final userModel = UserModel().obs;

  var isSignIn = false.obs;
  var firebaseAuthController = SignInController();

  ///[Stream] user on fireStore with GetXfire
  Stream<User?> get user => GetxFire.userChanges();

  @override
  void onInit() {
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
        email: emailController.value.text,
        password: passwordController.value.text,
        isSuccessDialog: true,
        onSuccess: (userCredential) {
          if (userCredential!.user != null) {
            success = true;
            userEmail = userCredential.user!.email;
            createNewUser(userEmail);
            isSignIn.value = true;

          } else {
            success = false;
          }
        },
        onError: (code, message) {
          GetxFire.openDialog.messageError(message!);
        });
  }

  Future<void> createNewUser(String? userEmail) async {
    try {
      final fbCompany = AddCompanyController();
      var _user = UserModel(
        id: fbCompany.userModel.value.id,
        email: userEmail,
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
