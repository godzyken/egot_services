import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: Container(
        child: controller.obx(
            (state) => ListView.builder(
                  itemCount: state?.length,
                  itemBuilder: (context, index) {
                    return Text(state?[index].companyName ?? '');
                  },
                ),
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
  }
}
