import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/CompanyCard/views/company_card_view.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
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
          initState: (state) => RegisterServices(),
          autoRemove: true,
          builder: (_) {
            return Form(
              // key: _.formKey,
              onChanged: () => _.addCompanyC!.validateInputs,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onWillPop: () async {
                return await _.onWillPop();
              },
              child: Card(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Get.toNamed('/add-company',
                            arguments: Get.arguments, preventDuplicates: true),
                        child: buildNewCompanyCard(),
                      ),
                      TextFormField(
                        controller: _.emailController.value,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) => _.validateEmail(value!),
                        onEditingComplete: () =>
                            GetUtils.isEmail(_.emailController.value.text)
                                ? "Email OK!"
                                : "this isn't a valid email",
                        onSaved: (value) {
                          _.userModel!.email = value;
                        },
                      ),
                      TextFormField(
                        controller: _.passwordController.value,
                        decoration: const InputDecoration(labelText: 'Password'),
                        onSaved: (value) => _.passwordController.value.text = value!,
                        validator: (value) => _.validatePassword(value!),
                        obscureText: true,
                      ),
                      Obx(() {
                        return CheckboxListTile(
                          value: _.rememberme.value,
                          onChanged: (value) => _.rememberme.toggle(),
                          title: const Text('Remember me'),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: SignInButtonBuilder(
                          icon: Icons.add_business,
                          backgroundColor: Colors.blueGrey,
                          text: 'Register',
                          onPressed: () async {
                            if (_.emailController.value.text != '') {

                              return await _.register();
                            } else {
                              return Get.toNamed('/add-company');
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(_.isSignIn == null
                            ? ''
                            : (_.isSignIn.isTrue
                                ? 'Successfully registered ${_.userModel!.email}'
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

  TextStyle get textStyleName {
    return const TextStyle(
      color: Colors.redAccent,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );
  }

  TextStyle get textStyleCell {
    return const TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 16.5,
    );
  }

  GetBuilder buildNewCompanyCard() {
    return GetBuilder<AddCompanyController>(
        assignId: true,
        init: AddCompanyController(),
        builder: (_) {
          return Obx(() {
            return Container(
              color: Colors.transparent,
                child: _.userModel.value.id != null
                    ? modelCard(_)
                    : CompanyCardView(company: _.userModel.value.companyName));
          });
        });
  }

  Card modelCard(AddCompanyController _) {
    return Card(
        color: Colors.tealAccent,
        shadowColor: Colors.yellow,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Table(
          border: TableBorder.all(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(10.0),
            1: IntrinsicColumnWidth(flex: 10.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: const FlexColumnWidth(3.0),
          children: <TableRow>[
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      '${_.userModel.value.matriculation}',
                      style: textStyleName,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: Text(
                          '${_.userModel.value.companyName}',
                          style: textStyleName,
                        )),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      'Activité(s) :',
                      style: textStyleCell,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.activity}',
                          style: textStyleName),
                    ),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Container(
                        height: 32,
                        alignment: Alignment.center,
                        child:Text(
                      'Specialisation(s) :',
                      style: textStyleCell,
                            maxLines: 1
                    )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.specialisation}',
                          style: textStyleName),
                    ),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      'Status :',
                      style: textStyleCell,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.status}',
                          style: textStyleName),
                    ),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      'location :',
                      style: textStyleCell,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.location}',
                          style: textStyleName),
                    ),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      'Assurance :',
                      style: textStyleCell,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.assurance}',
                          style: textStyleName),
                    ),
                  ),
                ]),
            TableRow(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  shape: BoxShape.rectangle,
                ),
                children: [
                  Container(
                    height: 32,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.5, horizontal: 0.5),
                    child: Text(
                      'Length :',
                      style: textStyleCell,
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: Text('${_.userModel.value.length}',
                          style: textStyleName),
                    ),
                  ),
                ]),
          ],
        ));
  }
}
