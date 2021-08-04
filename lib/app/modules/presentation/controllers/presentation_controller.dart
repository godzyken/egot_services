import 'dart:async';

import 'package:egot_services/app/models/store_model.dart';
import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:egot_services/app/modules/presentation/repository/repository.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'dart:convert' show json;

class PresentationController extends SuperController<Store> {
  HomeController homeController = Get.find<HomeController>();
  StreamController<Store> streamController = StreamController<Store>();

  PresentationController({required this.repository});

  var presentation = FirebaseFirestore.instance
      .collection("presentation")
      .doc('contact')
      .snapshots();

  var count = 0.obs;
  
  final IStoreRepository repository;

  late User? user;

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
      "count":(count+1).toInt(),
    };
    
    DocumentReference documentReference = FirebaseFirestore.instance.collection('presentation').doc("contact");

    documentReference.update(contact);
  }

  @override
  void onInit() {
    user = Get.arguments;
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
    await homeController.firebaseAuth.signOut();
  }

  Future<void> handleGetContact(User? user) async {
    final response = await repository.getNews();
    if (response.id != null) {
      print(
          'People api gave a ${response.name} response. check logs for details.');
      print('People API ${response.id} response: ${response.name}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.toString());

    final String? namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      print('I see you know $namedContact!');
    } else {
      print('No contacts to display.');
    }
  }

  Future<void> getNewStorage() async {
    append(() => repository.getNews);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    print('onDetached called');
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print('onInactive called');
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print('onPaused called');
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    print('onResume called');
  }

/*  Future<void> driveConnectionToMedia() async {
    try {
      var media = drive.Media;
      var driveFile = drive.File;
    } catch (e) {

    }
  }*/

}
