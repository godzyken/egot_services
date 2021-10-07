import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

class RegisterController extends GetxController {
  static RegisterController? get to => Get.find();

  AddCompanyController? addCompanyC;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final firebaseAuthController = SignInController();

  final success = false.obs;

  final userModel = UserModel().obs;

  // final firebaseUser = Rxn<User>();
  // final fireStoreUser = Rxn<UserModel>();
  // final connect = GetxFire.firestore;
  final auth = GetxFire.auth;

  final Map<String, String> _dataUserCompany = {
    'email': 'isgodzy@gmail.com',
    'password': 'dattebayo',
    'companyName': 'Godzyken',
    'status': 'SASU',
    'specialisation': 'digitalisation des entreprises',
    'activity': 'Concepteur Developpeur App Flutter',
    'matriculation': '35356464RC',
    'location': 'Lyon',
    'assurance': 'MAAF',
    'length': '1',
    'rememberme': 'rememberme'
  };

  var isSignIn = false.obs;
  var rememberme = false.obs;

  Stream<User?> get user => GetxFire.userChanges();

  bool shouldPop = true;

  Future<bool> onWillPop() async {
    return shouldPop;
  }

  @override
  void onInit() {
    addCompanyC = AddCompanyController();

    super.onInit();
  }

  @override
  void onReady() async {
    ever(isSignIn, handleAuthChanged);
    isSignIn.value = auth.currentUser != null;
    auth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    update();

    super.onReady();
  }

  @override
  void onClose() {}

  void dialogError(String? msg) {
    Get.defaultDialog(
      title: 'Hi mé ké passo!',
      middleText: msg!,
    );
  }

  Future<void> register() async {
    await GetxFire.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
        isSuccessDialog: true,
        onSuccess: (userCredential) {
          if (userCredential!.user != null) {

            isSignIn.value = true;

            update();
          } else {
            success.value = false;
          }
        },
        onError: (code, message) {
          GetxFire.openDialog.messageError(message!);
        });
  }

  autoLogin() {
    final box = GetStorage();
    if (box.read("datausercompany") != null) {
      final data = box.read("datausercompany") as Map<String, String>;
      login(data["companyname"], data["email"], data["password"],
          data['rememeberme']);
    }
  }

  void login(String? companyname, String? email, String? password,
      String? rememberme) {
    if (email != '' && password != '') {
      if (GetUtils.isEmail(email!)) {
        if (email == _dataUserCompany['email'] &&
            password == _dataUserCompany["password"]) {
          if (rememberme != null) {
            final box = GetStorage();
            box.write('dataUser', {
              "email": email,
              "password": password,
              "rememberme": rememberme,
            });
            box.write('dataUserCompany', {
              "email": email,
              "password": password,
              "rememberme": rememberme,
              "companyName": addCompanyC!.companyNameController.value,
              "status": addCompanyC!.statusController.value,
              "specialisation": addCompanyC!.specialisationController.value,
              "activity": addCompanyC!.activityController.value,
              "matriculation": addCompanyC!.matriculationController.value,
              "location": addCompanyC!.locationController.value,
              "assurance": addCompanyC!.assuranceController.value,
              "length": addCompanyC!.lengthController.value,
            });
          } else {
            final box = GetStorage();
            if (box.read('dataUser') != null && box.read('dataUseCompany')) {
              box.erase();
            }
          }

          isSignIn.value = true;
        } else {
          dialogError('Data user is not valid');
        }
      } else {
        dialogError('Data email is not valid');
      }
    } else {
      dialogError('Data user is empty');
    }
  }

  handleAuthChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAndToNamed(Routes.HOME);

      isSignIn.value = true;
      update();
    } else {
      Get.until((route) => Get.currentRoute == '/register');
    }
  }

}
