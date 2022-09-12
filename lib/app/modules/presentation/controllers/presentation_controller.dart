import 'dart:async';
import 'dart:convert' show json;

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:egot_services/app/modules/presentation/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:getxfire/getxfire.dart';

class PresentationController extends SuperController<Store> {
  PresentationController({required this.repository});
  IStoreRepository? repository;
  User? user;
  HomeController homeController = Get.find<HomeController>();
  StreamController<Store> streamController = StreamController<Store>();
  var userModel = UserModel().obs;
  var presentation = FirebaseFirestore.instance
      .collection("presentation")
      .doc('contact')
      .snapshots();

  var count = 0.obs;

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  void startStream() {
    presentation.listen((event) {
      streamController.sink.add(event.data()!['count']);
    });
  }

  ///function Ok with cloud field have to create
  void addContact() {
    Map<String, int> contact = {
      "count": (count + 1).toInt(),
    };

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('presentation').doc("contact");

    documentReference.update(contact);
  }

  void addUser() {
    userModel.update((val) {
      val!.id = user!.uid;
      val.companyName = user!.displayName;
      val.email = user!.email;
      val.createdAt = user!.refreshToken;
      val.avatarUrl = user!.photoURL;
    });
  }

  @override
  void onInit() {
    user = homeController.firebaseAuthController.user;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  FutureOr onClose() {
    streamController.close();
    super.onClose();
  }

  void logout() async {
    await SignInController().firebaseAuth.signOut();
  }

  Future<void> handleGetContact(User? user) async {
    final response = await repository?.getNews();
    if (response?.id != null) {
      if (kDebugMode) {
        print(
            'People api gave a ${response?.name} response. check logs for details.');
      }
      if (kDebugMode) {
        print('People API ${response?.id} response: ${response?.name}');
      }
      return;
    }
    final Map<String, dynamic> data = json.decode(response.toString());

    final String? namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      if (kDebugMode) {
        print('I see you know $namedContact!');
      }
    } else {
      if (kDebugMode) {
        print('No contacts to display.');
      }
    }
  }

  Future<void> getNewStorage() async {
    append(() => repository!.getNews);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    if (kDebugMode) {
      print('onDetached called');
    }
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    if (kDebugMode) {
      print('onInactive called');
    }
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    if (kDebugMode) {
      print('onPaused called');
    }
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    if (kDebugMode) {
      print('onResume called');
    }
  }

/*  Future<void> driveConnectionToMedia() async {
    try {
      var media = drive.Media;
      var driveFile = drive.File;
    } catch (e) {

    }
  }*/

}
