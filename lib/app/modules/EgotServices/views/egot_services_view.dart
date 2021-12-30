import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/egot_services_controller.dart';

class EgotServicesView extends GetView<EgotServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'EgotServicesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
