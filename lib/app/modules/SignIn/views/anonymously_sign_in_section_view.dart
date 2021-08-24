import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AnonymouslySignInSectionView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (_) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(),
              Container(),
              Visibility(
                  visible: _.success != null,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _.success == null
                          ? ''
                          : (_.success
                              ? 'Successfully signed in, uid: ${_.userID}'
                              : 'Sign in failed'),
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
