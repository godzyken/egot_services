import 'dart:developer';

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/auth/services/auth_services.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  RegisterServices? _registerServices;
  FirebaseApp? service;
  AuthService? authService;

  User? get user => _user.value;
  var isSignIn = false.obs;
  var userToken = ''.obs;

  @override
  onInit() {
    ever(_user, _setInitialScreen);

    authService = AuthService();

    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());

    auth.authStateChanges().listen(
      (event) {
        isSignIn.value = event != null;
      },
      onError: (err) => dialogError(err),
      cancelOnError: true,
      onDone: () => log('auth state change !!'),
    );

    auth.idTokenChanges().listen(
      (event) {
        isSignIn.value = event != null;
      },
      onError: (err) => dialogError(err),
      cancelOnError: true,
      onDone: () => log('id token change !!'),
    );

    super.onInit();
  }

  @override
  void refresh() {
    _user.refresh();
    auth.currentUser?.reload();
  }

  dialogError(String? msg) {
    Get.defaultDialog(
      title: 'Hi mé ké passo!',
      middleText: msg!,
    );
  }

  Future<bool?> connectToFirebase() async {
    try {
      var authInfo = auth.app.options;
      if (authInfo.storageBucket != null) {
        log('FirebaseFireStore connected successful : $authInfo');
        return true;
      } else {
        log('FirebaseFireStore connected failed : $authInfo');
        return false;
      }
    } on FirebaseAuthException catch (code, e) {
      log('Code erreur: $code, message erreur: $e');
      return false;
    }
  }

  createUser(String? name, String? email, String? password) async {
    await auth.createUserWithEmailAndPassword(
        email: email!.trim(), password: password!);
    auth.currentUser?.updateDisplayName(name);
  }

  login(String email, String password) async {
    try {
      var _authResult = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      await _registerServices!.getUser(_authResult.user!.uid).then((value) {
        UserModel? user = Get.find<UserController>().user;

        return user = UserModel(
            email: value.email ? null : user?.email,
            id: value.id ? null : user?.id,
            companyName: value.companyName ? null : user?.companyName,
            matriculation: value.matriculation ? null : user?.matriculation,
            activity: value.activity ? null : user?.activity,
            specialisation: value.specialisation ? null : user?.specialisation,
            status: value.status ? null : user?.status,
            location: value.location ? null : user?.location,
            assurance: value.assurance ? null : user?.assurance,
            length: value.length ? null : user?.length);
      });

      update();
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  signOut() async {
    try {
      await auth
          .signOut()
          .then((value) => Get.rootDelegate.toNamed('/Register'));
      Get.find<UserController>().clear();
      userToken.close();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _setInitialScreen(User? user) {
    if (user?.uid.isNotEmpty == null) {
      Get.offAllNamed('/sign-in');
    } else {
      Get.offAllNamed('/home');
    }
  }

  @override
  void onReady() {
    auth.userChanges().listen((event) {
      isSignIn.value = event != null;
    },
        onError: (err) => dialogError(err),
        cancelOnError: true,
        onDone: () => log('User is changed and signed in !'));

    super.onReady();
  }

  @override
  void onClose() {
    signOut();
    _user.close();
    _registerServices!.onClose();
    service!.delete();
  }
}
