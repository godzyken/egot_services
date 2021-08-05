import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/archives_controller.dart';

class ArchivesView extends GetView<ArchivesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArchivesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Archives View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
