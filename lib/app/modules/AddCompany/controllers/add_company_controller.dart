import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/assurance_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompanyController extends GetxController {
  static AddCompanyController? get to => Get.find();
  AssuranceController? assuranceC;
  RegisterController? fbConnect;
  ModalRoute? mountRoute;
  List<GlobalKey<FormState>?> formKeys = [];
  final pageController =
      PageController(initialPage: 1, viewportFraction: 1.0, keepPage: true);

  final statusController = TextEditingController().obs;
  final assuranceController = TextEditingController().obs;
  final specialisationController = TextEditingController().obs;
  final companyNameController = TextEditingController().obs;
  final activityController = TextEditingController().obs;
  final matriculationController = TextEditingController().obs;
  final lengthController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final userModel = UserModel().obs;

  bool success = false;

  var cards = <Card>[];
  var h = Get.mediaQuery.size.height;
  var w = Get.mediaQuery.size.width;

  @override
  void onInit() {
    assuranceC = AssuranceController();
    fbConnect = RegisterController();
    formKeys = [GlobalKey<FormState>()];

    update();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void createNewUser() async {
    try {
      var _authResult =
          fbConnect!.firebaseAuthController.firebaseAuth.currentUser;

      var _user = UserModel(
        id: _authResult!.uid,
        email: _authResult.email,
        companyName: companyNameController.value,
        activity: activityController.value,
        matriculation: matriculationController.value,
        length: lengthController.value,
        location: locationController.value,
        status: statusController.value,
        assurance: assuranceController.value,
        specialisation: specialisationController.value,
      );

      _user = await updateUserCompanyName(_authResult.displayName, _user.companyName);
      if (await RegisterServices().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
        success = true;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  updateUserCompanyName(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.companyName = newValue1;
      userModel.companyName = newValue2;
    });
  }

  updateUserCompanyActivity(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.activity = newValue1;
      userModel.activity = newValue2;
    });
  }

  updateUserCompanySpeciality(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.specialisation = newValue1;
      userModel.specialisation = newValue2;
    });
  }

  updateUserCompanyIdentity(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.matriculation = newValue1;
      userModel.matriculation = newValue2;
    });
  }

  updateUserCompanyLocation(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.location = newValue1;
      userModel.location = newValue2;
    });
  }

  updateUserCompanyStatus(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.status = newValue1;
      userModel.status = newValue2;
    });
  }

  updateUserCompanyLength(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.length = newValue1;
      userModel.length = newValue2;
    });
  }
  updateUserCompanyAssurance(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.assurance = newValue1;
      userModel.assurance = newValue2;
    });
  }

  validateInputs() {
    print('button');
    for (int i = 0; i < formKeys.length; i++) {
      if (formKeys[i]!.currentState!.validate()) {
        formKeys[i]!.currentState!.save();
        update();
      }
    }
  }
}
