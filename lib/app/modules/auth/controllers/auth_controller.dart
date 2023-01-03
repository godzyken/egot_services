import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final _user = Rxn<User?>();
  RegisterServices? _registerServices;
  FirebaseApp? service;

  User? get user => _user.value;
  var isSignIn = false.obs;
  var userToken = ''.obs;

  @override
  onInit() {
    _user.bindStream(auth.authStateChanges());

    auth.authStateChanges().listen(
      (event) {
        isSignIn.value = event != null;
      },
      onError: (err) => dialogError(err),
      cancelOnError: true,
      onDone: () => print('auth state change !!'),
    );

    auth.idTokenChanges().listen(
      (event) {
        isSignIn.value = event != null;
      },
      onError: (err) => dialogError(err),
      cancelOnError: true,
      onDone: () => print('id token change !!'),
    );

    auth.userChanges().listen((event) {
      isSignIn.value = event != null;
    },
        onError: (err) => dialogError(err),
        cancelOnError: true,
        onDone: () => print('User is changed and signed in !'));

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
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (code, e) {
      print('Code erreur: $code, message erreur: $e');
      return false;
    }
  }

  createUser(String? name, String? email, String? password) async {
    await auth.createUserWithEmailAndPassword(
        email: email!.trim(), password: password!);
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
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
