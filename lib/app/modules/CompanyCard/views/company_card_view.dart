import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'package:egot_services/app/models/user_model.dart';

import '../controllers/company_card_controller.dart';

class CompanyCardView extends GetView<CompanyCardController> {
  const CompanyCardView({Key? key, uid, UserModel? company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.rootDelegate.toNamed('/add-company'),
        child: buildNewCompanyCard());
  }

  TextStyle get textStyleName {
    return const TextStyle(
      color: Colors.blueAccent,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
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
    return GetBuilder<CompanyCardController>(
        assignId: true,
        init: CompanyCardController(),
        builder: (_) {
          return Obx(() {
            return Card(
                color: Colors.white38,
                shadowColor: Colors.yellow,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                clipBehavior: Clip.antiAlias,
                elevation: 2.0,
                borderOnForeground: true,
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
                    2: FixedColumnWidth(16.0),
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                                height: 32,
                                width: 32,
                                alignment: Alignment.center,
                                child: Text(
                                  '${_.userModel.value.companyName}',
                                  style: textStyleName,
                                )),
                          ),
                          Container(
                            height: 64,
                            color: Colors.transparent,
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.activity}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
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
                              'Spécialisation(s) :',
                              style: textStyleCell,
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.specialisation}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.status}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.location}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
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
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.assurance}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
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
                              'Size :',
                              style: textStyleCell,
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: Text('${_.userModel.value.length}',
                                  style: textStyleName),
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.red,
                          ),
                        ]),
                  ],
                ));
          });
        });
  }
}
