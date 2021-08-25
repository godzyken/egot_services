import 'package:egot_services/app/helpers/show_loading.dart';
import 'package:egot_services/app/modules/Register/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class SignInController extends GetxController {
  bool success = false;
  bool showAuthSecretTextField = false;
  bool showProviderTokenField = true;
  var isRegister = false.obs;
  String? userID = '';
  String? provider = 'Google';

  int selection = 0;

  User? user;

  FirebaseAuth firebaseAuth = GetxFire.auth;

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

  login(context) async {
    try {
      showLoading();
      await GetxFire.signInWithGoogle(onSuccess: (userCredential) {
        final user = userCredential!.user;

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign In ${user!.uid} with Google')));
      }, onError: (code, message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in with Google: $message'),
        ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  loginWep(String? email, String? password) async {
    try {
      var _authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      Get.find<UserController>().user =
          await RegisterServices().getUser(_authResult.user!.uid);
    } catch (e) {
      Get.snackbar("Error signing in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  logout() async {
    try {
      await firebaseAuth.signOut();
      Get.find<UserController>().clear();
      GetxFire.signOut();
    } catch (e) {
      Get.snackbar("Error signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

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

  Future<void> signInAnonymously() async {
    await GetxFire.signInAnonymously(onSuccess: (userCredential) {
      print('Signed in Anonymously as user ${userCredential!.user!.uid}');
    }, onError: (code, message) {
      print('Failed to sign in Anonymously\n$message');
    });
  }

  // Example code of how to sign in with Github.
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign In ${user!.uid} with GitHub'),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with GitHub: $e'),
        ),
      );
    }
  }

  signInWithEmailAndPassword() async {
    return await GetxFire.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (userCredential) {
          return '${userCredential!.user!.email} signed in';
        },
        onError: (code, message) {
          return 'Failed to sign in with Email & Password\n$message';
        });
  }

  Future<void> _signInWithGoogle(context) async {
    await GetxFire.signInWithGoogle(onSuccess: (userCredential) {
      final user = userCredential!.user;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign In ${user!.uid} with Google'),
      ));
    }, onError: (code, message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $message'),
        ),
      );
    });
  }

  // Example code of how to sign in with Facebook.
  Future<void> _signInWithFacebook(context) async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(
        tokenController.text,
      );
      final  user = (await firebaseAuth.signInWithCredential(credential)).user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign In ${user!.uid} with Facebook'),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Facebook: $e'),
        ),
      );
    }
  }

  // Example code of how to sign in with Twitter.
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign In ${user!.uid} with Twitter'),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Twitter: $e'),
        ),
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
