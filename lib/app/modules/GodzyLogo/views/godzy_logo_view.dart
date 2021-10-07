import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/godzy_logo_controller.dart';

class GodzyLogoView extends GetView<GodzyLogoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/lottie/image/godzy_logo.png"),
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }
}
