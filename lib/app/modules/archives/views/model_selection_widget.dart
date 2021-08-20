import 'package:egot_services/app/helpers/firebase_manager.dart';
import 'package:egot_services/app/models/available_model.dart';
import 'package:egot_services/app/modules/archives/controllers/archives_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelSelectionWidget extends GetWidget<ArchivesController> {
  final Function onTap;
  final FirebaseManager firebaseManager;

  const ModelSelectionWidget(
      {Key? key, required this.onTap, required this.firebaseManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var models = <AvailableModel>[];
    String selected;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 4.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            shape: BoxShape.rectangle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 10.0,
                spreadRadius: 4.0,
              )
            ],
          ),
          child: Text(
            'Choose a Model',
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.65,
          child: ListView.builder(
              itemCount: models.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTap(models[index]),
                  child: Card(
                    elevation: 4.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.network(models[index].image!),
                        ),
                        Text(
                          models[index].name!,
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.0),
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
