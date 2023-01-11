import 'package:egot_services/app/modules/Register/views/register_view.dart';
import 'package:egot_services/app/modules/snap_scroll/views/snap_scroll_view.dart';
import 'package:egot_services/app/themes/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/images_assets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.isSignIn.isTrue
                ? Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: ExactAssetImage(ImagesAssets.carrelageBackground),
                      colorFilter:
                          ColorFilter.mode(Colors.white30, BlendMode.softLight),
                      opacity: 0.5,
                      fit: BoxFit.fill,
                    )),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      clipBehavior: Clip.hardEdge,
                      fit: StackFit.loose,
                      children: const <Widget>[
                        SnapScrollView(),
                        DraggableListMenu()
                      ],
                    ))
                : const RegisterView();
          }),
      backgroundColor: Colors.transparent,
      /*  floatingActionButton: FloatingActionButton(
          onPressed: () => {Get.to(() => const GodzyLogoView())},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            clipBehavior: Clip.hardEdge,
            child: const GodzyLogoView(),
          ),
        ),*/
    );
  }
}

class DraggableListMenu extends GetView<HomeController> {
  const DraggableListMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location!;
        return Container(
          constraints: const BoxConstraints.expand(),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (c) => DraggableScrollableSheet(
                initialChildSize: .3,
                minChildSize: .10,
                maxChildSize: 0.9,
                expand: true,
                builder: (BuildContext buildContext, _) {
                  return ListView.builder(
                    controller: c.scrollController,
                    itemCount: c.menuList.length + 2,
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
                              style: ListTileStyle.list,
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
                              selectedTileColor: currentLocation ==
                                      c.menuList[index - 1].routeName
                                  ? Colors.grey[300]
                                  : null,
                              selected: true,
                              onTap: () => c.selectedMenu.value = index - 1,
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              enabled: true,
                              tileColor: Colors.yellowAccent,
                              onLongPress: () => Get.rootDelegate.toNamed(
                                  "${c.menuList.elementAt(index - 1).routeName}"))),
                        );
                      }
                    },
                  );
                }),
          ),
        );
      },
    );
  }
}
