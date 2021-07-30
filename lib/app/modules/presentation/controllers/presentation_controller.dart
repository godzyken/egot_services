import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'dart:convert' show json;

class PresentationController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

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
  void onClose() {}

  void logout() async {
    await homeController.firebaseAuth.signOut();
  }

  Future<void> handleGetContact(User? user) async {
    final response = GetConnect(withCredentials: true);
    if (response.trustedCertificates != null) {
      print('People api gave a ${response.trustedCertificates} response. check logs for details.');
      print('People API ${response.userAgent} response: ${response.httpClient.defaultContentType}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.httpClient.defaultContentType);
    

    final String? namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      print('I see you know $namedContact!');
    } else {
      print('No contacts to display.');
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
