import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/devis_controller.dart';

class DevisView extends GetView<DevisController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevisView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DevisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
