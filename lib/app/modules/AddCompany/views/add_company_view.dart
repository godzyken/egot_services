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
      body: SingleChildScrollView(
          child: GetBuilder<AddCompanyController>(builder: (_) {
            return Form(
              key: _.formKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          buildCompanyName(_),
                          buildActivity(_),
                          buildSpecialisation(_),
                          buildMatriculation(_),
                          buildLocation(_),
                          buildStatus(_),
                          buildAssurance(_),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
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
          })),
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
            return Get.to(const RegisterView(), arguments: [_.formKey.currentContext!.owner]);
          }
        },
      ),
    );
  }

  TextFormField buildAssurance(AddCompanyController _) {
    return TextFormField(
      controller: _.assuranceController,
      decoration: const InputDecoration(labelText: 'Company assurance'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your assurance';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.assurance = value;
      },
    );
  }

  TextFormField buildStatus(AddCompanyController _) {
    return TextFormField(
      controller: _.statusController,
      decoration: const InputDecoration(labelText: 'Company status'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your company status';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.status = value;
      },
    );
  }

  TextFormField buildLocation(AddCompanyController _) {
    return TextFormField(
      controller: _.locationController,
      decoration: const InputDecoration(labelText: 'Company location'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your company location';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.location = value;
      },
    );
  }

  TextFormField buildMatriculation(AddCompanyController _) {
    return TextFormField(
      controller: _.matriculationController,
      decoration: const InputDecoration(labelText: 'Company identity'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your company identity';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.matriculation = value;
      },
    );
  }

  TextFormField buildSpecialisation(AddCompanyController _) {
    return TextFormField(
      controller: _.specialisationController,
      decoration: const InputDecoration(labelText: 'specialisation'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your specialisation';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.specialisation = value;
      },
    );
  }

  TextFormField buildActivity(AddCompanyController _) {
    return TextFormField(
      controller: _.activityController,
      decoration: const InputDecoration(labelText: 'activity'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your activity';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.activity = value;
      },
      onEditingComplete: () => GetUtils.isLengthGreaterOrEqual(_.activityController, 3) ? print("Activity valid") : print("Activity not valid"),
    );
  }

  TextFormField buildCompanyName(AddCompanyController _) {
    return TextFormField(
      controller: _.companyNameController,
      decoration: const InputDecoration(labelText: 'Company Name'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter your company name';
        }
        return null;
      },
      onSaved: (value) {
        _.userModel.value.companyName = value;
      },
    );
  }
}
