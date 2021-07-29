import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/archives_controller.dart';

class ArchivesView extends GetView<ArchivesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArchivesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ArchivesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
