import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
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
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (controller.user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
                "REFRESH",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onPressed: () {
                controller.handleGetContact(controller.user);
              },
            ),
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
      );
    } else {
      return GetBuilder<SignInController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("You are not currently signed in."),
              ElevatedButton(
                onPressed: controller.login(context),
                child: const Text('Sign In'),
              ),
            ],
          );
        },
      );
    }
  }
}
