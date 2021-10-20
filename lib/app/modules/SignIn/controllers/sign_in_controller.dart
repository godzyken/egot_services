import 'package:egot_services/app/helpers/show_loading.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class SignInController extends GetxController {
  static SignInController? get to => Get.find();

  final firebaseAuth = AuthController().auth;

  bool success = false;
  bool showAuthSecretTextField = false;
  bool showProviderTokenField = true;
  var isRegister = false.obs;
  String? userID = '';
  String? provider = 'Google';

  int selection = 0;

  User? user;

  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();
  final tokenSecretController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    GetxFire.openDialog.confirm(onYesClicked: onYesClicked);

    super.onInit();
  }

  @override
  void onReady() async {
    GetxFire.openDialog.messageSuccess("Create User successfully!");
    super.onReady();
  }

  @override
  void onClose() {}

  onYesClicked() async {
    final User? user = GetxFire.currentUser;
    if (user == null) {
      print('No one has signed in.');
      return;
    }
    await GetxFire.signOut();

    final String uid = user.uid;
    print('$uid has successfully signed out.');
  }

  onErrorCatch(code, message) {
    if (code == 'email-already-in-use') {
      GetxFire.openDialog.messageError('Maa ké passa : $message',
          title: 'Error Create User: ${code.code}',
          duration: const Duration(seconds: 12));
      Get.toNamed('/sign-in');
    } else {
      GetxFire.openDialog.messageError('Maa ké passu : $message',
          title: 'Error Create User: ${code.code}',
          duration: const Duration(seconds: 12));
    }
    if (code == 'invalid-email') {
      GetxFire.openDialog.messageError('Maa ké passi : $message',
          title: 'Error Create User: ${code.code}',
          duration: const Duration(seconds: 12));
      GetxFire.currentUser?.delete();
    } else {
      GetxFire.openDialog.messageError('Maa ké passo : $message',
          title: 'Error Create User: ${code.code}',
          duration: const Duration(seconds: 12));
    }
  }

  onSuccess(userCredential) async {
    if (userCredential!.user != null) {
      isRegister.value = true;
      GetxFire.openDialog.messageSuccess('on success login: $userCredential',
          title: 'userCredential', duration: const Duration(seconds: 12));

      update();
    } else {
      isRegister.value = false;
    }
  }


  login(context) async {
    try {
      showLoading();
      await GetxFire.signInWithGoogle(
          onSuccess: onSuccess, onError: onErrorCatch);
    } on FirebaseAuthException catch (code, e) {
      print('Error login code: $e');
      GetxFire.openDialog.messageError(
        "Error Login to your Account : ${code.message}",
        title: 'Error login 1: ${code.code}',
        duration: const Duration(seconds: 30),
      );
    }
  }

  loginWep(String? email, String? password) async {
    try {
      var _authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      Get.find<UserController>().user =
          await RegisterServices().getUser(_authResult.user!.uid);

    } on FirebaseAuthException catch (code, e) {
      print('wattttata: $e');
      GetxFire.openDialog.messageError(
          'Wats wrong? : ${code.message}',
          title: 'Error during login Wep: ${code.code}',
          duration: const Duration(seconds: 12));
    }
  }

  logout() async {
    try {
      await firebaseAuth.signOut();
      Get.find<UserController>().clear();
      GetxFire.signOut();

      GetxFire.openDialog.messageSuccess(
          'Ciao banbino',
          title: 'logout success',
          duration: const Duration(seconds: 12));

    } on FirebaseAuthException catch (code, e) {
      print('Error logout: $e');
      GetxFire.openDialog.messageError(
          'Maa ké zako : $e',
          title: 'Error during logout: ${code.code}',
          duration: const Duration(seconds: 12));
    }
  }

  // TODO: sign in provider.
  signInWithOtherProvider() {
    switch (selection) {
      case 0:
        _signInWithGithub;
        update();
        break;
      case 1:
        _signInWithFacebook;
        update();
        break;
      case 2:
        _signInWithTwitter;
        update();
        break;
      default:
        _signInWithGoogle;
        update();
    }
  }

  // TODO: sign in with Email & Password.
  signInWithEmailAndPassword() async {
    return await GetxFire.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        isSuccessDialog: true,
        isErrorDialog: true,
        onSuccess: onSuccess,
        onError: onErrorCatch);
  }

  // TODO: sign in with Github.
  Future<void> signInAnonymously() async {
    await GetxFire.signInAnonymously(
        onSuccess: onSuccess, onError: onErrorCatch);
  }

  // TODO: sign in with Github.
  Future<void> _signInWithGithub(context) async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GithubAuthProvider githubProvider = GithubAuthProvider();
        userCredential = await firebaseAuth.signInWithPopup(githubProvider);
      } else {
        final AuthCredential credential = GithubAuthProvider.credential(
          tokenController.text,
        );
        userCredential = await firebaseAuth.signInWithCredential(credential);
      }

      final user = userCredential.user;

      GetxFire.openDialog.messageSuccess(
          'your User account on : ${user!.displayName}',
          title: 'Create github User successfully: ${user.email}',
          duration: const Duration(seconds: 12));
    } on FirebaseAuthException catch (code, e) {
      print('Failed to github log error: $e');

      GetxFire.openDialog.messageError(
          'Failed to sign in, Error: ${code.message}',
          title: 'GitHub login error: ${code.code}',
          duration: const Duration(seconds: 12));
    }
  }

  // TODO: sign in with Google.
  Future<void> _signInWithGoogle(context) async {
    await GetxFire.signInWithGoogle(
        isSuccessDialog: true,
        isErrorDialog: true,
        onSuccess: onSuccess,
        onError: onErrorCatch);
  }

  // TODO: sign in with Facebook.
  Future<void> _signInWithFacebook(context) async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(
        tokenController.text,
      );
      final user = (await firebaseAuth.signInWithCredential(credential)).user;

      GetxFire.openDialog.messageSuccess(
        "Sin in with Account facebook:",
        title: 'Your user id : ${user!.uid}',
        duration: const Duration(seconds: 30),
      );
    } on FirebaseAuthException catch (code, e) {
      print('Ké pasapasa: $e');
      GetxFire.openDialog.messageError(
          'Failed to sign in with Facebook: ${code.code}',
          title: 'Error Create User: ${code.message}',
          duration: const Duration(seconds: 12));
    }
  }

  // TODO: sign in with Twitter.
  Future<void> _signInWithTwitter(context) async {
    try {
      UserCredential? userCredential;

      if (kIsWeb) {
        TwitterAuthProvider twitterProvider = TwitterAuthProvider();
        await firebaseAuth.signInWithPopup(twitterProvider);
      } else {
        final AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: tokenController.text,
            secret: tokenSecretController.text);
        userCredential = await firebaseAuth.signInWithCredential(credential);
      }

      final user = userCredential!.user;

      GetxFire.openDialog.messageSuccess(
        "'Sign In ${user!.uid} with Twitter'",
        title: 'Twitter login success',
        duration: const Duration(seconds: 30),
      );
    } on FirebaseAuthException catch (code, e) {
      print('Error during login: $e');
      GetxFire.openDialog.messageSuccess(
        "'Sign Error:  ${code.message}'",
        title: 'Twitter login failed: ${code.code}',
        duration: const Duration(seconds: 30),
      );
    }
  }

  handleRadioButtonSelected(int? value) {
    selection = value!;

    switch (selection) {
      case 0:
        {
          provider = 'GitHub';
          showAuthSecretTextField = false;
          showProviderTokenField = true;
          update();
        }
        break;

      case 1:
        {
          provider = 'Facebook';
          showAuthSecretTextField = false;
          showProviderTokenField = true;
          update();
        }
        break;

      case 2:
        {
          provider = 'Twitter';
          showAuthSecretTextField = true;
          showProviderTokenField = true;
          update();
        }
        break;

      default:
        {
          provider = 'Google';
          showAuthSecretTextField = false;
          showProviderTokenField = false;
          update();
        }
    }
  }
}
