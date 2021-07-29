import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sketch_my_wishes_controller.dart';

class SketchMyWishesView extends GetView<SketchMyWishesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SketchMyWishesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SketchMyWishesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
