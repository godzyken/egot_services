import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'package:egot_services/app/models/use_x_models.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(Get.arguments['userId']),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_.user!.companyName),
              centerTitle: true,
            ),
            body: Container(
              child: controller.obx(
                  (state) => StreamBuilder<UserModel?>(
                      stream: _.findAllUsers(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          var user = snapshot.data!;
                          return Text(
                            user['name'],
                            style: const TextStyle(
                                fontSize: 50, color: Colors.blue),
                          );
                        }
                      }),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onError: (error) => Center(
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
