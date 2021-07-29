import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presentation_controller.dart';

class PresentationView extends GetView<PresentationController> {
  const PresentationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Presentation EGOTE'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            const SizedBox(
              height: 16,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(controller.user!.photoURL!),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Display Name : ${controller.user!.displayName!}',
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              controller.user!.email!,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 120),
              child: ElevatedButton(
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onPressed: () {
                  controller.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
