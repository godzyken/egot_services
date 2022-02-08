import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:egot_services/app/modules/CompanyCard/views/company_card_view.dart';

import '../controllers/list_company_controller.dart';

class ListCompanyView extends GetView<ListCompanyController> {
  const ListCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GetX<ListCompanyController>(
          init: ListCompanyController(),
          builder: (_) => _.userList == null
              ? const Text('loading...')
              : Expanded(
                  child: ListView.builder(
                  itemCount: _.userList!.value.length,
                  itemBuilder: (_, index) => CompanyCardView(
                      uid: controller.listController.userModel!.id,
                      company: controller.userList!.value[index]),
                )),
        ),
      ],
    ));
  }
}
