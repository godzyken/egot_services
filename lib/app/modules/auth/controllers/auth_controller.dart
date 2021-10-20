import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AuthController extends GetxController {
  final auth = GetxFire.auth;
  final _user = Rxn<User?>();
  RegisterServices? _registerServices;

  User? get currentUser => auth.currentUser;

  User? get user => _user.value;

  var isSignIn = false.obs;

  @override
  onInit() {
    _user.bindStream(auth.authStateChanges());

    auth.authStateChanges().listen(
          (event) {
        isSignIn.value = event != null;
      },
      onError: (err) => dialogError(err),
      cancelOnError: true,
      onDone: () => print('ke passa passa '),
    );

    super.onInit();
  }

  void dialogError(String? msg) {
    Get.defaultDialog(
      title: 'Hi mé ké passo!',
      middleText: msg!,
    );
  }

  Future<bool?> connectToFirebase() async {
    try {
      var authInfo = await auth.app.options;
      if (authInfo != null) {
        print('auth Info : ${authInfo.storageBucket}');
        return true;
      } else {
        print(' auth info is null: ${authInfo.databaseURL}');
        return false;
      }
    } on FirebaseAuthException catch (code, e) {
      Get.snackbar('Erreur Auth connection : $code', 'Erreur message2: $e',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 20));
    }
  }

  createUser(String? name, String? email, String? password) async {
    try {
      await GetxFire.createUserWithEmailAndPassword(
          email: email!.trim(),
          password: password!,
          isSuccessDialog: true,
          onSuccess: onSuccess,
          onError: onErrorCatch)
          .then((userCred) {
        if (userCred!.additionalUserInfo!.isNewUser) {
         Get.find<UserController>().user?.id = userCred.user!.uid;
         Get.find<UserController>().user?.email = userCred.user!.email;

          GetxFire.firestore.createData(
            collection: 'users',
            data: Get.find<UserController>().user!.toJson(),
            id: userCred.user!.uid,
            onError: (err) =>
                GetxFire.openDialog.messageError(
                    'Maa ké passa : $err',
                    title: 'Erreur Create User',
                    duration: const Duration(seconds: 12)),
            isErrorDialog: true,
          );

          update();
        } else {

          GetxFire.firestore
              .updateData(
            collection: 'users',
            data: Get.find<UserController>().user!.toJson(),
            id: Get.find<UserController>().user!.id,
            onError: (err) =>
                GetxFire.openDialog.messageError(
                    'Maa ké passi : ${err.toString()}',
                    title: 'Erreur Create User: $err',
                    duration: const Duration(seconds: 12)),
            isErrorDialog: true,
          )
              .then((value) => login(email, password));

          update();
        }
      });
    } on FirebaseAuthException catch (code, e) {
      GetxFire.openDialog.messageError('Maa ké passo : $code',
          title: 'Erreur Create User: $e',
          duration: const Duration(seconds: 12));
    }
  }

  void login(String email, String password) async {
    try {
      var _authResult = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      await _registerServices!.getUser(_authResult.user!.uid).then((value) {
        var user = Get
            .find<UserController>()
            .user;

        user = UserModel(
            email: value.email,
            id: value.id,
            companyName: value.companyName,
            matriculation: value.matriculation,
            activity: value.activity,
            specialisation: value.specialisation,
            status: value.status,
            location: value.location,
            assurance: value.assurance,
            length: value.length
        );

        print('Get user : $user');
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

  void signOut() async {
    try {
      await auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
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
}
