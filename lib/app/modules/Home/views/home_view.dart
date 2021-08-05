import 'dart:ui';

import 'package:egot_services/app/modules/GodzyLogo/views/godzy_logo_view.dart';
import 'package:egot_services/app/themes/app_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) => ListView.builder(
              itemCount: _.menuList.value.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const SizedBox(height: 15.0);
                } else if (index == _.menuList.length + 1) {
                  return const SizedBox(height: 100.0);
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
                    child: ListTile(
                      leading: _.menuList[index - 1].icon,
                      title: Text(
                        _.menuList[index - 1].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppThemes.fontFamily,
                          color: _.selectedMenu.value == index - 1
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                      ),
                      subtitle: Text(
                        _.menuList[index - 1].subtitle,
                        style: TextStyle(
                            fontSize: 11,
                            color: _.selectedMenu == index - 1
                                ? Colors.black
                                : Colors.grey),
                      ),
                      selectedTileColor:
                          Get.currentRoute == _.menuList[index - 1].routeName
                              ? Colors.grey[300]
                              : null,
                      selected: _.selectedMenu.value == index - 1,
                      onTap: () => _.selectedMenu.value = index - 1,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      enabled: true,
                      tileColor: Colors.yellowAccent,
                    ),
                  );
                }
              }),
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image:
              ExactAssetImage("assets/lottie/image/carrelage_background.jpg"),
          fit: BoxFit.cover,
        )),
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/devis'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          clipBehavior: Clip.hardEdge,
          child: GodzyLogoView(),
        ),
      ),
    );
  }
}
