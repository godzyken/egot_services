import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompanyController extends GetxController {
  var formKey = GlobalKey<FormState>();
  final statusController = TextEditingController();
  final assuranceController = TextEditingController();
  final specialisationController = TextEditingController();
  final companyNameController = TextEditingController();
  final activityController = TextEditingController();
  final matriculationController = TextEditingController();
  final lengthController = TextEditingController();
  final locationController = TextEditingController();

  bool success = false;
  final userModel = UserModel().obs;

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

  void createNewUser(context) async {

    try {
      final fbConnect = Get.find<RegisterController>();

      var _authResult = fbConnect.firebaseAuthController.firebaseAuth.currentUser;

      var _user = UserModel(
        id: _authResult!.uid,
        email: _authResult.email,
        companyName: _authResult.displayName,
        activity: activityController,
        matriculation: matriculationController,
        length: lengthController,
        location: locationController,
        status: statusController,
        assurance: assuranceController,
        specialisation: specialisationController,
      );
      update();
      if (await RegisterServices().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        update();
        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  updateUserModel(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.id = newValue1!;
      userModel.email = newValue2!;
    });
  }

}
