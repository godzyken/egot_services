import 'package:flutter/material.dart';

class Menu {
  Icon? icon;
  String title;
  String subtitle;
  String? routeName;

  Menu(
      {this.icon, this.routeName, required this.title, required this.subtitle});
}

final menus = [
  Menu(
    icon: const Icon(Icons.info_rounded, size: 40.0),
    title: 'Presentation',
    subtitle: 'Bienvenue chez Egote !',
    routeName: '/presentation',
  ),
  Menu(
    icon: const Icon(Icons.architecture_sharp, size: 40.0),
    title: 'Réalisation',
    subtitle: 'Nos archives !',
    routeName: '/archives',
  ),
  Menu(
    icon: const Icon(Icons.home_repair_service_sharp, size: 40.0),
    title: 'Services',
    subtitle: 'Egote à votre services !',
    routeName: '/egot-services',
  ),
  Menu(
    icon: const Icon(Icons.settings_applications, size: 40.0),
    title: 'Applications',
    subtitle: 'Godzy services apps !',
    routeName: '/godzyapp',
  ),
];
