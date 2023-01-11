import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/images_assets.dart';
import '../controllers/godzy_logo_controller.dart';

class GodzyLogoView extends GetView<GodzyLogoController> {
  const GodzyLogoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: ExactAssetImage(ImagesAssets.godzyLogo),
            fit: BoxFit.fill,
          )),
        ),
      ),
    );
  }
}
