import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/avatar_body_controller.dart';

class AvatarBodyView extends GetView<AvatarBodyController> {
  const AvatarBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvatarBodyController>(
      assignId: true,
      init: AvatarBodyController(),
      builder: (_) => _.userModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(_.userModel.value.avatarUrl),
            ),
    );
  }
}
