import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.rootDelegate
          .toNamed('/:user', arguments: Get.parameters['userId']),
      child: buildNewUserView,
    );
  }

  GetBuilder<UserController> get buildNewUserView {
    return GetBuilder<UserController>(
        assignId: true,
        init: UserController(Get.parameters['userID']),
        builder: (_) => _.user == null
            ? const CircularProgressIndicator()
            : Obx(
                () => Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          _.user!.companyName,
                          style:
                              const TextStyle(fontSize: 50, color: Colors.blue),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          _.user!.activity,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          _.user!.specialisation,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          _.user!.location,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          _.user!.email,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        )),
                  ],
                ),
              ));
  }
}
