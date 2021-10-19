import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:getxfire/getxfire.dart';

class RegisterServices extends GetConnect {
  static RegisterServices get to => Get.find();
  final _firestore = GetxFire.firestore;

  var user = Get.find<AuthController>().user;

  // Section ['Users']
  Future<bool> createNewUser(UserModel? userModel) async {
    try {
      return await _firestore.createData(
          collection: "users",
          data: UserModel().toJson(),
          id: userModel!.id,
          isErrorDialog: true,
          onError: (code) {
            GetxFire.openDialog.messageError('Erreur message1: ${code}',
                title: 'Erreur connection database',
                duration: const Duration(seconds: 10));
          });
    } catch (e) {
      print('Create user failed $e');
      return false;
    }
  }

  Future<bool> updateUser(UserModel? userModel) async {
    print('thheeee brrrooout2');

    try {
      print('thheeee brrrooout3');
      if (user!.uid.isCurrency){
        print('thheeee brrrooout5');

        var newUser = user?.updateDisplayName(userModel!.companyName);
        print('User: $newUser');
        user?.updateEmail(userModel!.email);

        user?.getIdToken();

        return true;
      }
      return false;
    } on FirebaseAuthException catch (code, e) {
      print('Create user failed ${code.message}');
      GetxFire.openDialog.messageError('Erreur message: ${code.code}',
          title: 'Erreur connection database $e}',
          duration: const Duration(seconds: 10));
      return false;
    }
  }

  Future<UserModel> getUserDetail(String? uid) async {
    try {
      var _doc = await _firestore.getDetail(collection: "users", id: uid!);

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
    return _firestore.streamData(
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
      await _firestore.updateData(
          collection: "users/agents", id: uid, data: UserModel().toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Section ['Contacts']
  Future<bool> createContact(ContactModel? contactModel) async {
    try {
      await _firestore.createData(
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
    return _firestore.streamData(
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
