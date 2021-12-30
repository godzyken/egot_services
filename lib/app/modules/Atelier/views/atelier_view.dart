import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/atelier_controller.dart';

class AtelierView extends GetView<AtelierController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'AtelierView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
