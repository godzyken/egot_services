import 'package:egot_services/app/modules/AddCompany/controllers/assurance_controller.dart';
import 'package:egot_services/app/modules/Register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'package:get/get.dart';

import '../../../models/assurance_model.dart';
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
              // key: _.formKeys[_.formKeys.length - 1].currentState!.widget.key,
              onChanged: () => _.validateInputs(),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PageView(
                    controller: _.pageController,
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    onPageChanged: (value) => _.companyNameController.value,
                    children: [
                      buildCompanyName(_),
                      buildActivity(_),
                      buildSpecialisation(_),
                      buildMatriculation(_),
                      buildLocation(_),
                      buildStatus(_),
                      buildLength(_),
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
          onPressed: () => Get.to(const RegisterView())),
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
        child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                            "Your company assurance is : ${_.userModel.value.assurance}");
                      }),
                      const SizedBox(),
                      TextFormField(
                        controller: _.assuranceController.value,
                        decoration: const InputDecoration(
                            labelText: 'Company assurance', filled: true),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your assurance';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _.userModel.value.assurance = value;
                        },
                        onEditingComplete: () => TextInputAction.next,
                        onChanged: (value) =>
                            _.updateUserCompanyAssurance(value, value),
                      ),
                      const SizedBox(),
                      Container(
                          child: _.assuranceC!.provider.allowAutoSignedCert
                              ? Center(
                                  child: _.assuranceC!.obx((state) =>
                                      ListView.separated(
                                          itemBuilder: (context, index) {
                                            final Assurance assurance =
                                                state![index];
                                            return ListTile(
                                              onTap: () => Get.toNamed(
                                                  '/add-company',
                                                  arguments: assurance),
                                              title:
                                                  Text("\$${assurance.name}"),
                                              trailing: Text(
                                                  "\$${assurance.organizationsUrl}"),
                                              leading: AssuranceImage(
                                                  assurance: assurance),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                                color:
                                                    context.theme.disabledColor,
                                              ),
                                          itemCount: state!.length)),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ))
                    ],
                  ))
            ]),
      ),
    );
  }

  Card buildLength(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(
        child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                            "Your company length : ${_.userModel.value.length}");
                      }),
                      const SizedBox(),
                      TextFormField(
                        controller: _.lengthController.value,
                        decoration: const InputDecoration(
                            labelText: 'Company length', filled: true),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your company size';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _.userModel.value.length = value;
                        },
                        onEditingComplete: () => TextInputAction.next,
                        onChanged: (value) =>
                            _.updateUserCompanyLength(value, value),
                      ),
                    ],
                  ))
            ]),
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
        child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                            "Your company status is : ${_.userModel.value.status}");
                      }),
                      const SizedBox(),
                      TextFormField(
                        controller: _.statusController.value,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            labelText: 'Company status', filled: true),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your company status';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _.userModel.value.status = value;
                        },
                        onEditingComplete: () => TextInputAction.next,
                        onChanged: (value) =>
                            _.updateUserCompanyStatus(value, value),
                      )
                    ],
                  ))
            ]),
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
      child: Center(
        child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 1,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                            "Your company location : ${_.userModel.value.location}");
                      }),
                      const SizedBox(),
                      TextFormField(
                        controller: _.locationController.value,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            labelText: 'Company location', filled: true),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your company location';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _.userModel.value.location = value;
                        },
                        onEditingComplete: () => TextInputAction.next,
                        onChanged: (value) =>
                            _.updateUserCompanyLocation(value, value),
                      )
                    ],
                  ))
            ]),
      ),
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
        child: Center(
          child: Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.hardEdge,
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 1,
                    child: Wrap(
                      verticalDirection: VerticalDirection.down,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Obx(() {
                          return Text(
                              "Your company matriculate : ${_.userModel.value.matriculation}");
                        }),
                        const SizedBox(),
                        TextFormField(
                          controller: _.matriculationController.value,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              labelText: 'Company identity', filled: true),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your company identity';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _.userModel.value.matriculation = value;
                          },
                          onEditingComplete: () => TextInputAction.next,
                          onChanged: (value) =>
                              _.updateUserCompanyIdentity(value, value),
                        ),
                      ],
                    ))
              ]),
        ));
  }

  Card buildSpecialisation(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.yellowAccent,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(
        child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.hardEdge,
            children: [
              Expanded(
                  flex: 1,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                            "Your company specialisation is : ${_.userModel.value.specialisation}");
                      }),
                      const SizedBox(),
                      TextFormField(
                        controller: _.specialisationController.value,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            labelText: 'specialisation', filled: true),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your specialisation';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _.userModel.value.specialisation = value;
                        },
                        onEditingComplete: () => TextInputAction.next,
                        onChanged: (value) =>
                            _.updateUserCompanySpeciality(value, value),
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }

  Card buildActivity(AddCompanyController _) {
    return Card(
      key: key,
      semanticContainer: true,
      elevation: 12.0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      borderOnForeground: true,
      shadowColor: Colors.black12,
      child: Center(
        heightFactor: _.h / 2,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.hardEdge,
          children: [
            Expanded(
                flex: 1,
                child: Wrap(
                  verticalDirection: VerticalDirection.down,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Obx(() {
                      return Text(
                          "Your company activity is : ${_.userModel.value.activity}");
                    }),
                    const SizedBox(),
                    TextFormField(
                      controller: _.activityController.value,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'activity', filled: true),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your activity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _.userModel.value.activity = value;
                      },
                      onEditingComplete: () => TextInputAction.next,
                      onChanged: (value) =>
                          _.updateUserCompanyActivity(value, value),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Card buildCompanyName(AddCompanyController _) {
    return Card(
        key: key,
        semanticContainer: true,
        elevation: 12.0,
        color: Colors.red,
        margin: const EdgeInsets.symmetric(),
        borderOnForeground: true,
        shadowColor: Colors.black12,
        child: Center(
          heightFactor: _.h / 2,
          child: Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.hardEdge,
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 1,
                    child: Wrap(
                      verticalDirection: VerticalDirection.down,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Obx(() {
                          return Text(
                              "Your company name's is : ${_.userModel.value.companyName}");
                        }),
                        const SizedBox(),
                        TextFormField(
                          controller: _.companyNameController.value,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              labelText: 'Company Name', filled: true),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your company name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _.userModel.value.companyName = value;
                          },
                          onEditingComplete: () => TextInputAction.next,
                          onChanged: (value) =>
                              _.updateUserCompanyName(value, value),
                        ),
                        const SizedBox(),
                      ],
                    ))
              ]),
        ));
  }
}

class AssuranceImage extends GetView<AssuranceController> {
  final Assurance? assurance;

  const AssuranceImage({Key? key, this.assurance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssuranceController>(
        init: AssuranceController(),
        initState: (state) => controller.assurance.stream,
        builder: (_) {
          return CircleAvatar(
            backgroundImage: NetworkImage(assurance!.avatarUrl!),
          );
        });
  }
}
