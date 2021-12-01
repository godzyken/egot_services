import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';

class EmailPasswordFormView extends GetView<SignInController> {
  const EmailPasswordFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        builder: (_) => Form(
            key: _.formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Sign in with email and password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: _.emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Please enter some text';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _.passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Please enter some text';
                        return null;
                      },
                      obscureText: true,
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: SignInButton(
                          Buttons.Email,
                          text: 'Sign In',
                          onPressed: () async {
                            if (_.formKey.currentState!.validate()) {
                              await _.signInWithEmailAndPassword();
                            }
                          },
                        )),
                  ],
                ),
              ),
            )));
  }
}
