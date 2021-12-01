import 'package:egot_services/app/modules/AddCompany/controllers/assurance_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AddCompanyController extends GetxController {
  static AddCompanyController? get to => Get.find();
  AssuranceController? assuranceC;

  final registerServices = RegisterServices();
  final formKeys = <GlobalKey<FormState>>[].obs;
  final userModel = UserController().user;

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
