import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presentation_controller.dart';

class PresentationView extends GetView<PresentationController> {
  const PresentationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Presentation EGOTE'),
        centerTitle: true,
      ),
      body: buildMainContenair,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.greenAccent,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed('/home'), label: const Text('Get home')),
    );
  }

  ConstrainedBox get buildMainContenair {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 196.4, height: 199.0),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth > 600
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            color: Colors.greenAccent,
                            height: constraints.maxHeight < 450
                                ? constraints.maxHeight * 0.5
                                : constraints.maxHeight * 0.24,
                            width: constraints.maxWidth < 450
                                ? constraints.maxWidth * 0.24
                                : constraints.maxWidth * 0.5,
                            child: Center(
                              child: _avatarBody(context),
                            ),
                          ),
                          Container(
                            color: Colors.blueAccent,
                            height: constraints.maxHeight * 0.24,
                            width: constraints.maxWidth * 0.5,
                            child: FractionallySizedBox(
                              heightFactor: 0.7,
                              widthFactor: 0.7,
                              child: Center(
                                child: _infoContact(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.yellowAccent,
                          height: constraints.maxHeight * 0.24,
                          width: constraints.maxWidth * 0.5,
                          child: Center(
                            child: _optionContact(context),
                          ),
                        )),
/*                      const SizedBox(),
                    Container(
                      width: constraints.maxWidth * 0.5,
                      height: constraints.maxHeight * 0.24,
                      color: Colors.pink,
                      child: const Center(
                        child: Text('Right Sidebar'),
                      ),
                    ),*/
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          color: Colors.greenAccent,
                          height: constraints.maxHeight < 450
                              ? constraints.maxHeight * 0.5
                              : constraints.maxHeight * 0.24,
                          width: constraints.maxWidth < 450
                              ? constraints.maxWidth * 0.24
                              : constraints.maxWidth * 0.5,
                          child: Center(
                            child: _avatarBody(context),
                          ),
                        ),
                        Container(
                          color: Colors.blueAccent,
                          height: constraints.maxHeight * 0.24,
                          width: constraints.maxWidth * 0.5,
                          child: Center(
                            child: _infoContact(context),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(),
                    Container(
                      color: Colors.yellowAccent,
                      height: constraints.maxHeight * 0.24,
                      width: constraints.maxWidth * 0.5,
                      child: Center(
                        child: _optionContact(context),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _avatarBody(BuildContext context) {
    if (controller.user != null) {
      return GetBuilder<PresentationController>(
          assignId: true,
          builder: (_) => _.user!.uid == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(_.user!.photoURL!),
                      ),
                    ),
                  ],
                ));
    } else {
      return GetBuilder<SignInController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("You are not currently signed in."),
              ElevatedButton(
                onPressed: controller.login(context),
                child: const Text('Sign In'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _infoContact(BuildContext context) {
    if (controller.user != null) {
      return GetBuilder<PresentationController>(
        assignId: true,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                _.user!.displayName!,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _.user!.email!,
                style: const TextStyle(fontSize: 16, color: Colors.black45),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );
    } else {
      return GetBuilder<SignInController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("You are not currently signed in."),
              ElevatedButton(
                onPressed: _.login(context),
                child: const Text('Sign In'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _optionContact(BuildContext context) {
    if (controller.user != null) {
      return GetBuilder<PresentationController>(
        assignId: true,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 100),
                child: ElevatedButton(
                  child: const Text(
                    "Add+",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onPressed: () {
                    print("test d'\ajout de contact");
                    _.addContact();
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 100),
                child: ElevatedButton(
                  child: const Text(
                    "REFRESH",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onPressed: () {
                    print('action refresh');
                    _.handleGetContact(_.user);
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 100),
                child: ElevatedButton(
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onPressed: () {
                    _.logout();
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      return GetBuilder<SignInController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text("You are not currently signed in."),
              ElevatedButton(
                onPressed: controller.login(context),
                child: const Text('Sign In'),
              ),
            ],
          );
        },
      );
    }
  }
}
