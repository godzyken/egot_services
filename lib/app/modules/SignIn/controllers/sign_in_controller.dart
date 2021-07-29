import 'package:egot_services/app/modules/Home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class SignInController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    GetxFire.openDialog.confirm(onYesClicked: onYesClicked);

    super.onInit();
  }

  @override
  void onReady() async {
    GetxFire.openDialog.messageSuccess("Create User successfully!");
    super.onReady();
  }

  @override
  void onClose() {}

  onYesClicked() async {
    final User? user = GetxFire.currentUser;
    if (user == null) {
      print('No one has signed in.');
      return;
    }
    await GetxFire.signOut();

    final String uid = user.uid;
    print('$uid has successfully signed out.');
  }

  login(context) async {

    await GetxFire.signInWithGoogle(onSuccess: (userCredential) {
      final user = userCredential!.user;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign In ${user!.uid} with Google')));
    }, onError: (code, message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in with Google: $message'),
      ));
    });
  }

}
