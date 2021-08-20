import 'dart:ui';

import 'package:egot_services/app/modules/GodzyLogo/views/godzy_logo_view.dart';
import 'package:egot_services/app/themes/app_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          'EGOTE + RMC',
          style: TextStyle(color: Colors.lightGreenAccent),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        leading: TextButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () => print('exit'),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        children: const <Widget>[DraggableListMenu()],
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/godzy-logo'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          clipBehavior: Clip.hardEdge,
          child: GodzyLogoView(),
        ),
      ),
    );
  }
}

class DraggableListMenu extends StatelessWidget {
  const DraggableListMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (c) =>
          DraggableScrollableSheet(
              initialChildSize: .3,
              minChildSize: .10,
              maxChildSize: 0.9,
              expand: true,
              builder: (BuildContext buildContext, _) {
                return ListView.builder(
                  controller: c.scrollController,
                  itemCount: c.menuList.value.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return const SizedBox(height: 15.0);
                    } else if (index == c.menuList.length + 1) {
                      return const SizedBox(height: 20.0);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Obx(() => ListTile(
                              leading: c.menuList[index - 1].icon,
                              title: Text(
                                c.menuList[index - 1].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppThemes.fontFamily,
                                  color: c.selectedMenu.value == index - 1
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              ),
                              subtitle: Text(
                                c.menuList[index - 1].subtitle,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: c.selectedMenu.value == index - 1
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                              selectedTileColor: Get.currentRoute ==
                                      c.menuList[index - 1].routeName
                                  ? Colors.grey[300]
                                  : null,
                              selected: c.selectedMenu.value == index - 1,
                              onTap: () => c.selectedMenu.value = index - 1,
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              enabled: true,
                              tileColor: Colors.yellowAccent,
                              onLongPress: () => Get.toNamed(
                                  "${c.menuList.value.elementAt(index - 1).routeName}"),
                            )),
                      );
                    }
                  },
                );
              }),
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: ExactAssetImage("assets/lottie/image/carrelage_background.jpg"),
        fit: BoxFit.cover,
      )),
    );
  }
}
