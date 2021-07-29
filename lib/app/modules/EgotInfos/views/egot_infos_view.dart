import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/egot_infos_controller.dart';

class EgotInfosView extends GetView<EgotInfosController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EgotInfosView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EgotInfosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
