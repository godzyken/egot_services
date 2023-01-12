import 'package:egot_services/app/modules/SignIn/views/user_info_card_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';
import 'anonymously_sign_in_section_view.dart';
import 'email_password_form_view.dart';
import 'other_providers_sign_in_section_view.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      assignId: true,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign In'),
            centerTitle: true,
            actions: <Widget>[
              Builder(builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: () async {
                      await _.logout();
                    },
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: const <Widget>[
              UserInfoCardView(),
              EmailPasswordFormView(),
              AnonymouslySignInSectionView(),
              OtherProvidersSignInSectionView(),
            ],
          ),
        );
      },
    );
  }
}
