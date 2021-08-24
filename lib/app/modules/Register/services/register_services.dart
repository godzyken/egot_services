import 'package:egot_services/app/models/use_x_models.dart';
import 'package:getxfire/getxfire.dart';

class RegisterServices {
  final _firestore = GetxFire.firestore;

  // Section ['Users']
  Future<bool> createNewUser(UserModel? userModel) async {
    try {
      await _firestore.createData(
          collection: "users", data: UserModel().toJson(), id: userModel!.id);
      return true;
    } catch (e) {
      print(e);
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

  Stream<QuerySnapshot<Object?>> streamUsers(String? uid) {
    return _firestore.streamData(
      collection: "users",
      collectionChild: "agents",
      idChild: uid!,
    );
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
          collection: "users/agents",
          id: uid,
          data: UserModel().toJson()
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Section ['Contacts']
  Future<bool> createContact(ContactModel? contactModel) async {
    try {
      await _firestore.createData(
          collection: "contacts", data: ContactModel().toJson(), id: contactModel!.id);
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
