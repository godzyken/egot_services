import 'package:egot_services/app/modules/presentation/controllers/presentation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getxfire/getxfire.dart';

class PresentationView extends GetView<PresentationController> {
  const PresentationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Presentation Entreprise'),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: LayoutBuilder(
          key: key,
          builder: (context, constraints) => constraints.maxWidth > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            key: key,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            key: key,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            key: key,
                            child: Center(
                              child: Container(
                                height: constraints.maxHeight * 0.24,
                                width: constraints.maxWidth * 0.5,
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                // child: _avatarBody(context),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            key: key,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
      backgroundColor: Colors.greenAccent,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed('/home'), label: const Text('Get Home')),
    );
  }

  Widget _avatarBody(BuildContext context) {
    return GetBuilder<PresentationController>(
      assignId: true,
      init: PresentationController(repository: controller.repository),
      builder: (_) => _.user! == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(_.user!.photoURL!),
            ),
    );
  }
}
