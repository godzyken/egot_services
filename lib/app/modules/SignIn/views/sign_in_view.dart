import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/image/logo_bat_services.png",),
          const SizedBox(height: 20,),
          const Text("Google SignIn",
          style: TextStyle(fontSize: 40, color: Colors.white),),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                child: const Text(
                  "Sign In fi google",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onPressed: () => controller.login(context),
              ),
            ),
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}
