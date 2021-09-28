import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompanyController extends GetxController {
  static AddCompanyController? get to => Get.find();
  var formKey = GlobalKey<FormState>();
  final pageController = PageController(
    initialPage: 1, viewportFraction: 1.0, keepPage: true
  );

  var statusController = TextEditingController();
  var assuranceController = TextEditingController();
  var specialisationController = TextEditingController();
  var companyNameController = TextEditingController();
  var activityController = TextEditingController();
  var matriculationController = TextEditingController();
  var lengthController = TextEditingController();
  var locationController = TextEditingController();

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
