import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getxfire/getxfire.dart';

class RegisterController extends GetxController {
  static RegisterController? get to => Get.find();

  AddCompanyController? addCompanyC;
  final _registerServices = RegisterServices();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final firebaseAuthController = SignInController().obs;

  final authC = AuthController();
  UserModel? get userModel => Get.find<UserController>().user;

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

  /*void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }*/

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password is too short";
    }
    return null;
  }

  Future<void> register() async {

    try {
      if (await authC.connectToFirebase().then((value) => isSignIn.value = value!)) {


        await authC.createUser(userModel!.companyName,
            emailController.value.text, passwordController.value.text);

        print('create User With Email And Password! '
            '${authC.auth.currentUser!.uid}, '
            ' ${authC.user?.uid}');
      } else {
        print('error de connection!');
        return;
      }
    } on FirebaseAuthException catch (code, e) {

      print('Register error code: $e');
      GetxFire.openDialog.messageError(
        "Error creating Account : ${code.code}",
        title: 'Register Error : ${code.code}',
        duration: const Duration(seconds: 30),
      );
    }
  }

  onErrorCatch(code, message) {
    if (code == 'email-already-in-use') {
      GetxFire.openDialog.messageError(message!);
      Get.toNamed('/sign-in');
    } else {
      GetxFire.openDialog.messageError(code);
    }
    if (code == 'invalid-email') {
      GetxFire.openDialog.messageError('Elooot: $message');
      GetxFire.currentUser?.delete();
    } else {
      GetxFire.openDialog.messageError(code);
    }
  }

  onSuccess(userCredential) async {
    if (userCredential!.user != null) {
      isSignIn.value = true;
      GetxFire.openDialog.messageSuccess(userCredential);

      /*  await GetxFire.firestore.createData(
        collection: 'users',
        id: AddCompanyController().userModel.value.id,
        data: UserModel().toJson(),
        onError: (message) => dialogError(message),
        isErrorDialog: true,
      );*/

      update();
    } else {
      isSignIn.value = false;
    }
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
      Get.toNamed('/home');

      update();
    } else {
      Get.until((route) => Get.currentRoute == '/register');
    }
  }
}
