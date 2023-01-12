import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (_) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Anonyme"),
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        backgroundColor: Colors.grey.shade900),
                    onPressed: () async {
                      try {
                        await _.auth.signInAnonymously();
                        Get.snackbar('Success', 'Authentication réussie');
                        Get.toNamed('/home');
                      } catch (e) {
                        Get.snackbar('Failed', e.toString());
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Google"),
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        backgroundColor: Colors.grey.shade900),
                    onPressed: () async {
                      try {
                        await _.authService?.signInAnonymously();
                        Get.snackbar('Success', 'Authentication réussie');
                        Get.toNamed('/home');
                      } catch (e) {
                        Get.snackbar('Failed', e.toString());
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Email / Password"),
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        backgroundColor: Colors.grey.shade900),
                    onPressed: () => Get.toNamed('/sign-in'),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
