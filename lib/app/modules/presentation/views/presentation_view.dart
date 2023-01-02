import 'package:egot_services/app/modules/avatar_body/views/avatar_body_view.dart';
import 'package:egot_services/app/modules/presentation/controllers/presentation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user/views/user_view.dart';

class PresentationView extends GetView<PresentationController> {
  const PresentationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      extendBodyBehindAppBar: true,
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
                                        style: BorderStyle.none)),
                                child: const AvatarBodyView(),
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                border: const Border.symmetric(
                                    horizontal: BorderSide.none,
                                    vertical: BorderSide.none),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ]),
                            child: Center(
                              child: Container(
                                height: constraints.maxHeight * 0.24,
                                width: constraints.maxWidth * 0.8,
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(
                                        color: Colors.transparent,
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 5,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ]),
                                child: const UserView(),
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
      backgroundColor: Colors.transparent,
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () => Get.rootDelegate.toNamed('/home'), label: const Text('Get Home')),
    );
  }
}
