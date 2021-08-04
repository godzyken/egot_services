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
      body: GetBuilder<DevisController>(
        assignId: true,
        builder: (_) {
          return SafeArea(
              child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  print('rebuild TextFormField ${_.errorText!.value}');
                  return TextFormField(
                    onChanged: _.usernameChanged,
                    decoration: InputDecoration(
                        labelText: 'Username', errorText: _.errorText!.value),
                  );
                }),
                Obx(() => ElevatedButton(
                    onPressed: _.submitFunc.value,
                    child: const Text('Submit'))),
              ],
            ),
          ));
        },
      ),
    );
  }
}
