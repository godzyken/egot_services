import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/Register/views/register_view.dart';
import 'package:egot_services/app/modules/user/controllers/user_controller.dart';

class AuthController extends GetxController {
  final auth = GetxFire.auth;
  final _user = Rxn<User?>();
  RegisterServices? _registerServices;

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

  dialogError(String? msg) {
    Get.defaultDialog(
      title: 'Hi mé ké passo!',
      middleText: msg!,
    );
  }

  Future<bool?> connectToFirebase() async {
    try {
      var authInfo = await auth.app.options;
      if (authInfo != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (code, e) {
      GetxFire.openDialog.messageError('Error Auth connection : $code',
          title: 'Error message2: $e', duration: const Duration(seconds: 20));
    }
  }

  createUser(String? name, String? email, String? password) async {
    await GetxFire.createUserWithEmailAndPassword(
            email: email!.trim(),
            password: password!,
            isSuccessDialog: true,
            onSuccess: onSuccess,
            onError: onErrorCatch)
        .then((userCred) async {
      var user = Get.find<UserController>().user;
      //
      // user!.id = userCred?.user!.uid;
      // user.email = userCred?.user!.email;
      // user.companyName = userCred?.user!.displayName ?? name;
      // user.avatarUrl = userCred?.user?.photoURL;
      // user.tenantId = userCred?.user?.tenantId ?? 'tenantId empty';
      // user.emailVerified = userCred?.user?.emailVerified ?? false;
      // user.providerData =
      //     userCred?.user?.providerData ?? 'expect provider data';
      // user.phoneNumber =
      //     userCred?.user?.phoneNumber ?? 'enter a valid phone number';
      // user.refreshToken =
      //     userCred?.user?.refreshToken ?? 'No refresh token';

      if (userCred != null && userCred.additionalUserInfo!.isNewUser) {
        await _registerServices?.firestore.createData(
          collection: 'users',
          data: user!.toJson(),
          id: user.id,
          onError: (err) => GetxFire.openDialog.messageError(
              'Maa ké passa : $err',
              title: 'Erreur Create User',
              duration: const Duration(seconds: 12)),
          isErrorDialog: true,
        );

        update();
      } else {
        await _registerServices?.firestore
            .updateData(
              collection: 'users',
              data: user!.toJson(),
              id: user.id,
              onError: (err) => GetxFire.openDialog.messageError(
                  'Maa ké passi : ${err.toString()}',
                  title: 'Error Create User: $err',
                  duration: const Duration(seconds: 12)),
              isErrorDialog: true,
            )
            .then((value) => login(email, password));

        update();
      }
    },
            onError: (err) => GetxFire.openDialog.messageError(
                'Error Credential null: $err ',
                title: 'Error connection',
                duration: const Duration(seconds: 12)));
  }

  login(String email, String password) async {
    try {
      var _authResult = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      await _registerServices!.getUser(_authResult.user!.uid).then((value) {
        var user = Get.find<UserController>().user;

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
            length: value.length);

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

  signOut() async {
    try {
      await auth.signOut().then((value) => Get.offAll(const RegisterView()));
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
      GetxFire.openDialog.messageError(
        "Error creating Account 1: $code}",
        title: 'Register Error 1: $message',
        duration: const Duration(seconds: 30),
      );
      Get.rootDelegate.toNamed('/sign-in');
    } else {
      GetxFire.openDialog.messageError(
        "Error creating Account 2: $code}",
        title: 'Register Error 2: $message',
        duration: const Duration(seconds: 30),
      );
    }
    if (code == 'invalid-email') {
      GetxFire.openDialog.messageError(
        "Error creating Account 3: $code}",
        title: 'Register Error 3',
        duration: const Duration(seconds: 30),
      );
      GetxFire.currentUser?.delete();
    } else {
      GetxFire.openDialog.messageError(
        "Error creating Account 4: $message}",
        title: 'Register Error 4: $code',
        duration: const Duration(seconds: 30),
      );
    }
  }

  onSuccess(userCredential) async {
    if (userCredential!.user != null) {
      isSignIn.value = true;
      GetxFire.openDialog.messageSuccess(
        "creating Account Successfully: $userCredential}",
        title: 'Register ok :',
        duration: const Duration(seconds: 30),
      );
      ;

      await _registerServices?.firestore.updateData(
        collection: 'users',
        id: user!.uid,
        data: Get.find<UserController>().user!.toJson(),
        onError: (message) => dialogError(message),
        isErrorDialog: true,
      );

      update();
    } else {
      isSignIn.value = false;
    }
  }
}
