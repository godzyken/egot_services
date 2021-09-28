import 'package:egot_services/app/modules/Register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'package:get/get.dart';

import '../controllers/add_company_controller.dart';

class AddCompanyView extends GetView<AddCompanyController> {
  const AddCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add your Company'),
        centerTitle: true,
      ),
      body: GetBuilder<AddCompanyController>(
          init: AddCompanyController(),
          builder: (_) {
            return Form(
              key: _.formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PageView(
                    controller: _.pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildCompanyName(_),
                      buildActivity(_),
                      buildSpecialisation(_),
                      buildMatriculation(_),
                      buildLocation(_),
                      buildStatus(_),
                      buildAssurance(_),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: buildRegister(controller),
    );
  }

  Container buildRegister(AddCompanyController _) {
    return Container(
      width: 110,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 1.8, horizontal: 1.8),
      alignment: Alignment.bottomRight,
      child: SignInButtonBuilder(
        icon: Icons.add_business,
        iconColor: Colors.tealAccent,
        backgroundColor: Colors.lightBlue,
        text: 'Register',
        onPressed: () async {
          if (_.formKey.currentState!.validate()) {
            _.formKey.currentState!.save();
            return Get.to(const RegisterView(),
                arguments: [_.formKey.currentContext!.owner]);
          }
        },
      ),
    );
  }

  Card buildAssurance(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Text(
                  "Your company assurance is : ${_.userModel.value.assurance}");
            }),
            const SizedBox(),
            TextFormField(
              controller: _.assuranceController,
              decoration: const InputDecoration(labelText: 'Company assurance',
                  filled: true),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your assurance';
                }
                return null;
              },
              onSaved: (value) {
                _.userModel.value.assurance = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Card buildStatus(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Text(
                  "Your company status is : ${_.userModel.value.status}");
            }),
            const SizedBox(),
            TextFormField(
              controller: _.statusController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(labelText: 'Company status',
                  filled: true),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your company status';
                }
                return null;
              },
              onSaved: (value) {
                _.userModel.value.status = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Card buildLocation(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
                "Your company location : ${_.userModel.value.location}");
          }),
          const SizedBox(),
          TextFormField(
            controller: _.locationController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'Company location',
                filled: true),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your company location';
              }
              return null;
            },
            onSaved: (value) {
              _.userModel.value.location = value;
            },
          )
        ],
      ),),
    );
  }

  Card buildMatriculation(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
                "Your company matriculate : ${_.userModel.value.matriculation}");
          }),
          const SizedBox(),
          TextFormField(
            controller: _.matriculationController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'Company identity',
                filled: true),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your company identity';
              }
              return null;
            },
            onSaved: (value) {
              _.userModel.value.matriculation = value;
            },
          ),
        ],
      ))
    );
  }

  Card buildSpecialisation(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
                "Your company specialisation is : ${_.userModel.value.specialisation}");
          }),
          const SizedBox(),
          TextFormField(
            controller: _.specialisationController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'specialisation',
                filled: true),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your specialisation';
              }
              return null;
            },
            onSaved: (value) {
              _.userModel.value.specialisation = value;
            },
          ),
        ],
      ),),
    );
  }

  Card buildActivity(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
                "Your company activity is : ${_.userModel.value.activity}");
          }),
          const SizedBox(),
          TextFormField(
            controller: _.activityController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'activity',
                filled: true),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your activity';
              }
              return null;
            },
            onSaved: (value) {
              _.userModel.value.activity = value;
            },
            onEditingComplete: () =>
            GetUtils.isLengthGreaterOrEqual(_.activityController, 3)
                ? const Text("Activity valid")
                : const Text("Activity not valid"),
          )
        ],
      ),),
    );
  }

  Card buildCompanyName(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
                "Your company name's is : ${_.userModel.value.companyName}");
          }),
          const SizedBox(),
          TextFormField(
            controller: _.companyNameController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                labelText: 'Company Name',
              filled: true
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter your company name';
              }
              return null;
            },
            onSaved: (value) {
              _.userModel.value.companyName = value;
            },
          ),
        ],
      )),
    );
  }
}
