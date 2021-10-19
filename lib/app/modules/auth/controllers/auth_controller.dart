import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class AuthController extends GetxController {
  final auth = GetxFire.auth;


  final Rxn<User?> _user = Rxn<User?>();
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
      if(authInfo != null) {
        print('auth Info : ${authInfo.storageBucket}');
        return true;

      } else {
        print(' auth info is null: ${authInfo.databaseURL}');
        return false;
      }
    } on FirebaseAuthException catch (code, e) {
      Get.snackbar('Erreur Auth connection : $code', 'Erreur message2: $e', snackPosition: SnackPosition.TOP, duration: Duration(seconds: 20));
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
          .then((userCred) async {
        if (userCred!.additionalUserInfo!.isNewUser) {
          var user = Get.find<UserController>().user;

          user = UserModel(
            id: userCred.user!.uid,
            email: userCred.user!.email,
            companyName: name,
          );

          await GetxFire.firestore.createData(
            collection: 'users',
            data: user.toJson(),
            id: user.id,
            onError: (err) => GetxFire.openDialog.messageError('Maa ké passa : $err!'),
            isErrorDialog: true,
          );

          update();
        }
        else {
          var user = Get.find<UserController>().user;

          user = UserModel(
            id: currentUser!.uid,
            email: currentUser!.email,
            companyName: currentUser!.displayName ?? name,
          );

          await GetxFire.firestore.updateData(
            collection: 'users',
            data: UserModel().toJson(),
            id: user.id,
            onError: (err) => GetxFire.openDialog.messageError('Maa ké passi : $err!'),
            isErrorDialog: true,
          ).then((value) => login(email, password));

          update();
        }
      });
    } catch (e) {
      GetxFire.openDialog.messageError('Maa ké passo : ${e.toString()}!');
    }
  }

  void login(String email, String password) async {
    try {
      var _authResult = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await _registerServices!.getUser(_authResult.user!.uid);

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
