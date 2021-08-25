import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: GetBuilder<RegisterController>(
          init: RegisterController(),
          autoRemove: true,
          builder: (_) {
            return Form(
              key: _.formKey,
              onChanged: () => Get.arguments,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Get.toNamed('/add-company',
                            arguments: [], preventDuplicates: true),
                        child: buildNewCompanyCard(),
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
                        onEditingComplete: () =>
                            GetUtils.isEmail(_.emailController.text)
                                ? "Email OK!"
                                : "this isn't a valid email",
                        onSaved: (value) {
                          _.userModel.value.email = value;
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
                              return _.createNewUser();
                            } else {
                              return Get.offAll('/add-company');
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(_.success == null
                            ? ''
                            : (_.success
                                ? 'Successfully registered ${_.userModel.value.email}'
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

  GetBuilder buildNewCompanyCard() {
    return GetBuilder<AddCompanyController>(
        assignId: true,
        init: AddCompanyController(),
        builder: (_) {
          return Obx(() {
            return Card(
                color: Colors.blue,
                shadowColor: Colors.yellow,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                clipBehavior: Clip.antiAlias,
                elevation: 2.0,
                borderOnForeground: true,
                semanticContainer: true,
                child: ListBody(children: [
                  Text("Company Name: ${_.userModel.value.companyName}"),
                  const SizedBox(height: 2.0,),
                  Text(
                    "Status: ${_.userModel.value.status}",
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 2.0,),
                  Text("Activity: ${_.userModel.value.activity}"),
                  const SizedBox(height: 2.0,),
                  Text("Specialisation: ${_.userModel.value.specialisation}"),
                  const SizedBox(height: 2.0,),
                  Text("Identity: ${_.userModel.value.matriculation}"),
                  const SizedBox(height: 2.0,),
                  Text("Company's location: ${_.userModel.value.location}"),
                  const SizedBox(height: 2.0,),
                  Text("Company's assurance: ${_.userModel.value.assurance}"),
                  const SizedBox(height: 2.0,),
                ]));
          });
        });
  }
}
