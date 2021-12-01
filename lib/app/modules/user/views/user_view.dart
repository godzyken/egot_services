import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_.user!.companyName),
          centerTitle: true,
        ),
        body: Container(
          child: controller.obx(
                  (state) =>
                  StreamBuilder(
                      builder: (BuildContext context, AsyncSnapshot<
                          dynamic> snapshot) {
                        _.user = snapshot.data;
                        return Text("Stream : ${_.user!.companyName}");
                      }),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) =>
                  Center(
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )),
        ),
      );
    });
  }
}
