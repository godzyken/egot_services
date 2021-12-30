import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/devis_controller.dart';

class DevisView extends GetView<DevisController> {
  const DevisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.tealAccent, Colors.orangeAccent]),
        ),
        child: Scaffold(
          body: GetBuilder<DevisController>(
            assignId: true,
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  SelectedMaison(),
                  SizedBox(),
                  SelectedAppartement(),
                ],
              );
            },
          ),
          backgroundColor: Colors.transparent,
        ));
  }
}

class SelectedAppartement extends StatelessWidget {
  const SelectedAppartement({
    Key? key,
  }) : super(key: key);

  get image => const AssetImage('assets/lottie/image/appartement.png');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DevisController>(
      assignId: true,
      builder: (_) {
        return Container(
            constraints: const BoxConstraints(),
            child: Center(
              child: Obx(
                () => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _.isAppartement.value,
                  title: const Text('Appartement'),
                  onChanged: (value) =>
                      _.isAppartement.value = !_.isAppartement.value,
                  contentPadding: const EdgeInsets.all(18.0),
                  activeColor: Colors.green,
                  checkColor: Colors.black87,
                  secondary: Image(
                    image: image,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class SelectedMaison extends StatelessWidget {
  const SelectedMaison({
    Key? key,
  }) : super(key: key);

  get image => const AssetImage('assets/lottie/image/maison_indiv.png');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DevisController>(
      assignId: true,
      builder: (_) {
        return Container(
            constraints: const BoxConstraints(),
            child: Center(
              child: Obx(
                () => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _.isMaison.value,
                  title: const Text('Maison'),
                  onChanged: (value) => _.isMaison.value = !_.isMaison.value,
                  contentPadding: const EdgeInsets.all(18.0),
                  activeColor: Colors.green,
                  checkColor: Colors.black87,
                  secondary: Image(
                    image: image,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.55,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
