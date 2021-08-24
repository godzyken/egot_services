import 'package:egot_services/app/modules/Register/views/company_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (_) {
            return Form(
              key: _.formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Get.to(() => const CompanyView()),
                        child: buildNewCompanyCard(_),
                      ),
                      TextFormField(
                        controller: _.emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onEditingComplete: () => GetUtils.isEmail(_.emailController.text) ? print("Email OK!") : print("this isn't a valid email"),
                        onSaved: (value) {
                          _.userModel.email = value;
                        },
                      ),
                      TextFormField(
                        controller: _.passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: SignInButtonBuilder(
                          icon: Icons.add_business,
                          backgroundColor: Colors.blueGrey,
                          text: 'Register',
                          onPressed: () async {
                            if (_.formKey.currentState!.validate()) {
                              await _.register();
                              return _.createNewUser(
                                  _.userModel.email, _.userModel.companyName);
                            } else {
                              return Get.to(() => const CompanyView());
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(_.success == null
                            ? ''
                            : (_.success
                                ? 'Successfully registered ${_.userModel.email}'
                                : 'Registration failed')),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Card buildNewCompanyCard(RegisterController _) {
    return Card(
        color: Colors.blue,
        shadowColor: Colors.yellow,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderOnForeground: true,
        semanticContainer: true,
        child: Column(children: <Widget>[
          Obx(() {
            return Text("Company Name: ${_.userModel.companyName}");
          }),
          Obx(() {
            return Text("Status: ${_.userModel.status}");
          }),
          Obx(() {
            return Text("Activity: ${_.userModel.activity}");
          }),
          Obx(() {
            return Text("Specialisation: ${_.userModel.specialisation}");
          }),
          Obx(() {
            return Text("Identity: ${_.userModel.matriculation}");
          }),
          Obx(() {
            return Text("Company's location: ${_.userModel.location}");
          }),
          Obx(() {
            return Text("Company's assurance: ${_.userModel.assurance}");
          }),
        ]));
  }
}
