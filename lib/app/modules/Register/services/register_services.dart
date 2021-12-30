import 'package:getxfire/getxfire.dart';

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';

class RegisterServices extends GetConnect {
  static RegisterServices get to => Get.find();
  final firestore = GetxFire.firestore;

  // Section ['Users']
  Future<bool> createNewUser(UserModel? userModel) async {
    try {
      return await firestore
          .createData(
              collection: "users",
              data: userModel!.toJson(),
              id: userModel.id.toString(),
              isErrorDialog: true,
              onError: (code) {
                GetxFire.openDialog.messageError('Error message1: ${code}',
                    title: 'Error connection database 1',
                    duration: const Duration(seconds: 10));
              })
          .then((value) {
        if (value != false) {
          print('create data user successfully');
          GetxFire.openDialog.messageSuccess('data users is create:',
              title: 'create data user successfully',
              duration: const Duration(seconds: 10));
          AuthController().isSignIn.value = true;
          Get.rootDelegate.toNamed('/home');
          return true;
        } else {
          print('create data user failed');
          GetxFire.openDialog.messageError('Error message2}',
              title: 'Error connection database 2',
              duration: const Duration(seconds: 10));
          return false;
        }
      });
    } on FirebaseAuthException catch (code, e) {
      print('Create user failed $e}');
      GetxFire.openDialog.messageError('Error message: ${code.message}',
          title: 'Error created data users ${code.code}}',
          duration: const Duration(seconds: 10));
      return false;
    }
  }

  Future<bool> updateUser(UserModel? userModel) async {
    try {
      userModel?.id = AuthController().user?.uid;

      return await firestore.updateData(
          collection: "users",
          data: userModel!.toJson(),
          id: userModel.id,
          isErrorDialog: true,
          onError: (code) {
            GetxFire.openDialog.messageError('Error Update: $code',
                title: 'Update user failed',
                duration: const Duration(seconds: 10));
          });
    } on FirebaseAuthException catch (code, e) {
      print('Update user failed $e}');
      GetxFire.openDialog.messageError('Error update 2: ${code.message}',
          title: 'Error to update data users ${code.code}}',
          duration: const Duration(seconds: 10));
      return false;
    }
  }

  Future<UserModel> getUserDetail(String? uid) async {
    try {
      var _doc = await firestore.getDetail(collection: "users", id: uid!);

      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      var _doc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Object?>> streamGetUsers(String? uid) {
    return firestore.streamData(
      collection: "users",
      collectionChild: "agents",
      idChild: uid!,
    );
  }

  Stream<List<UserModel>> usersStream(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("agents")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = []..length = 500;
      for (var element in query.docs) {
        retVal.add(UserModel.fromDocumentSnapshot(element));
      }
      return retVal;
    });
  }

  Future<void> addAgent(String? content, String? uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("agents")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateAgent(bool newAgent, String? uid, String? agentId) async {
    try {
      await firestore.updateData(
          collection: "users/agents", id: uid, data: UserModel().toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Section ['Contacts']
  Future<bool> createContact(ContactModel? contactModel) async {
    try {
      await firestore.createData(
          collection: "contacts",
          data: ContactModel().toJson(),
          id: contactModel!.id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> addContact(String? content, String? uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("contacts")
          .add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Object?>> streamContact(String? uid) {
    return firestore.streamData(
        collection: "users", collectionChild: "contacts", idChild: uid);
  }

  Future<void> updateContact(
      bool? newContact, String? uid, String? contactId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("contacts")
          .doc(contactId)
          .update({"done": newContact!});
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
