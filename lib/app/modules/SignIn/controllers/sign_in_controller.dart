import 'package:egot_services/app/helpers/show_loading.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController? get to => Get.find();

  final firebaseAuth = AuthController().auth;
  late final User? user;

  bool success = false;
  bool showAuthSecretTextField = false;
  bool showProviderTokenField = true;
  var isRegister = false.obs;
  String? userID = '';
  String? provider = 'Google';

  int selection = 0;

  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();
  final tokenSecretController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // GetxFire.openDialog.confirm(onYesClicked: onYesClicked);

    super.onInit();
  }

  @override
  void onReady() async {
    // GetxFire.openDialog.messageSuccess("Create User successfully!");
    super.onReady();
  }

  @override
  void onClose() {}

  onYesClicked() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      print('No one has signed in.');
      return;
    }
    await firebaseAuth.signOut();

    final String uid = user.uid;
    print('$uid has successfully signed out.');
  }

/*  onErrorCatch(code, message) {
    if (code == 'email-already-in-use') {
      GetxFire.openDialog.messageError('Email is wrong : $message',
          title: 'Create User: $code', duration: const Duration(seconds: 12));
      Get.rootDelegate.toNamed('/sign-in');
    } else {
      GetxFire.openDialog.messageError('Maa ké passu : $message',
          title: 'Error Create User: $code',
          duration: const Duration(seconds: 12));
    }
    if (code == 'wrong-password') {
      GetxFire.openDialog.messageError('Error Password : $message',
          title: 'Enter Password: ${code}',
          duration: const Duration(seconds: 12));
      GetxFire.currentUser?.delete();
    } else {
      GetxFire.openDialog.messageError('Error password : $message',
          title: 'Enter Password: ${code}',
          duration: const Duration(seconds: 12));
    }
    if (code == 'invalid-email') {
      GetxFire.openDialog.messageError('Maa ké passi : $message',
          title: 'Error Create User: ${code}',
          duration: const Duration(seconds: 12));
      GetxFire.currentUser?.delete();
    } else {
      GetxFire.openDialog.messageError('Maa ké passo : $message',
          title: 'Error Create User: ${code}',
          duration: const Duration(seconds: 12));
    }
  }*/

  onSuccess(UserCredential? userCredential) async {
    if (userCredential!.user != null) {
      isRegister.value = true;

      Get.rootDelegate.toNamed('/home');

      AuthController().isSignIn.value = true;

      update();
    } else {
      isRegister.value = false;
    }
  }

  login(context) async {
    try {
      showLoading();
      await signInWithOtherProvider();
    } on FirebaseAuthException catch (code, e) {
      print('Error login code : $code, message : $e');
      rethrow;
    }
  }

/*  loginWep(String? email, String? password) async {
    try {
      var _authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      Get.find<UserController>().user =
          await RegisterServices().getUser(_authResult.user!.uid);
    } on FirebaseAuthException catch (code, e) {
      print('wattttata: $e');
      GetxFire.openDialog.messageError('Wats wrong? : ${code.message}',
          title: 'Error during login Wep: ${code.code}',
          duration: const Duration(seconds: 12));
    }
  }*/

  logout() async {
    try {
      await firebaseAuth.signOut();
      Get.find<UserController>().clear();
    } on FirebaseAuthException catch (code, e) {
      print('Code Error logout: $code, message : $e');
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
        _signInWithEmailAndPassword;
        update();
    }
  }

  // TODO: sign in with Email & Password.
  Future<UserCredential> _signInWithEmailAndPassword() async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(), password: passwordController.text);
  }

  // TODO: sign in with Github.
  Future<void> signInAnonymously() async {
    await firebaseAuth.signInAnonymously();
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

      print('your User account on : ${user!.displayName}');
    } on FirebaseAuthException catch (code, e) {
      print('Failed to github log error: $e\n');
      print('Failed to sign in, Error: ${code.message}');
    }
  }

  // TODO: sign in with Google.
/*  Future<void> _signInWithGoogle(context) async {
    await firebaseAuth.signInWithGoogle(
        isSuccessDialog: true,
        isErrorDialog: true,
        onSuccess: onSuccess,
        onError: onErrorCatch);
  }*/

  // TODO: sign in with Facebook.
  Future<void> _signInWithFacebook(context) async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(
        tokenController.text,
      );
      final user = (await firebaseAuth.signInWithCredential(credential)).user;

      print("Sin in with Account facebook: ${user!.uid}");
    } on FirebaseAuthException catch (code, e) {
      print('Ké pasapasa: $e\n');
      print('Failed to sign in with Facebook: ${code.code}');
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

      print('Sign In ${user!.uid} with Twitter');
    } on FirebaseAuthException catch (code, e) {
      print('Error during login: $e\n');
      print("Sign Error:  ${code.message}");
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
          provider = 'Email & Password';
          showAuthSecretTextField = false;
          showProviderTokenField = false;
          update();
        }
    }
  }
}
