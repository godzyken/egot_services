import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpdateUserDialogView extends GetView {
  const UpdateUserDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        builder: (_) => AlertDialog(
          title: const Text('Update profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: _.nameController,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'Company Name'),
                ),
                TextFormField(
                  controller: _.urlController,
                  decoration: const InputDecoration(labelText: 'photoURL'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  validator: (String? value) {
                    if (value!.isNotEmpty) {
                      var uri = Uri.parse(value);
                      if (uri.isAbsolute) {
                        //TODO: get the data with dart:io or http and check it here
                        return null;
                      }
                      return 'Faulty URL!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _.user!.updatePhotoURL(_.urlController.text);
                  _.user!.updateDisplayName(_.nameController.text);
                },
                child: const Text('Update'),
            ),
          ],
        ),
    );
  }
}
