import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ouvrage_controller.dart';

class OuvrageView extends GetView<OuvrageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'OuvrageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
