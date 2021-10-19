import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/assurance_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AddCompanyController extends GetxController {
  static AddCompanyController? get to => Get.find();
  AssuranceController? assuranceC;
  final registerServices = RegisterServices();

  final formKeys = <GlobalKey<FormState>>[].obs;
  final fbConnect = AuthController();
  final pageController =
      PageController(initialPage: 0, viewportFraction: 1.0, keepPage: true);
  final statusController = TextEditingController().obs;
  final assuranceController = TextEditingController().obs;
  final specialisationController = TextEditingController().obs;
  final companyNameController = TextEditingController().obs;
  final activityController = TextEditingController().obs;
  final matriculationController = TextEditingController().obs;
  final lengthController = TextEditingController().obs;
  final locationController = TextEditingController().obs;
  final lengthC = 0.obs;
  final userModel = UserModel().obs;
  var user = UserController().user;

  var pageChanged = 0.obs;
  var success = false.obs;
  var h = Get.mediaQuery.size.height;
  var w = Get.mediaQuery.size.width;

  @override
  void onInit() {
    update();
    super.onInit();
  }

  @override
  void onReady() {
    assuranceC = AssuranceController();
    super.onReady();
  }

  @override
  void onClose() {}

  // Future<List<String?>> createNewUser(bool? isNew, UserModel? model, String? datalist) async {
  //
  //   if (isNew != false) {
  //    var newUser = UserModel(
  //      id:  userModel.value.id ?? fbConnect.user!.uid,
  //      email: userModel.value.email ?? fbConnect.user!.email,
  //      companyName: userModel.value.companyName ? companyNameController.value.selection : fbConnect.user!.displayName,
  //      status: userModel.value.status ?? statusController.value.selection,
  //      activity: userModel.value.activity ?? activityController.value.selection,
  //      assurance: userModel.value.assurance ?? assuranceController.value.selection,
  //      length: userModel.value.length ?? lengthController.value.selection,
  //      specialisation: userModel.value.specialisation ?? specialisationController.value.selection,
  //      location: userModel.value.location ?? locationController.value.selection,
  //      matriculation: userModel.value.matriculation ?? matriculationController.value.selection,
  //
  //    );
  //    print('@@@@new user : $newUser');
  //    datalist = Get.find<CompanyCardController>().
  //
  //    if (await _registerServices!.createNewUser(newUser)) {
  //      return 'tentative de register';
  //    }
  //   }
  //
  //   update();
  //
  //   return _user;
  // }

  String? validateName(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Provide valid Company Name";
    }
    return null;
  }

  String? validateAlphabet(String value) {
    if (!GetUtils.isAlphabetOnly(value)) {
      return "Provide valid words";
    }
    return null;
  }

  String? validateNum(String value) {
    if (!GetUtils.isNumericOnly(value)) {
      return "Provide valid number";
    }
    return null;
  }

  updateUserCompanyName(String? newValue1, String? newValue2) {
    userModel.update((userModel) {
      userModel!.companyName = newValue1;
      userModel.companyName = newValue2;
    });

    update();

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

    user!.specialisation = userModel.value.specialisation;
    print('${user!.specialisation}');

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

  updateUserCompanyLength(int? newValue1, int? newValue2) {
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

    user = userModel.call(userModel.value);

    print('user result : ${user!.toJson()}');

  }


  validateInputs() {
    for (int i = 0; i < formKeys.length; i++) {
      print('formky lengh ${formKeys.length}');
      if (formKeys[i].currentState!.validate()) {
        formKeys[i].currentState!.save();
        update();
      }
    }
  }
}
