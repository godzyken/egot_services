import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mentions_legals_controller.dart';

class MentionsLegalsView extends GetView<MentionsLegalsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'MentionsLegalsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
