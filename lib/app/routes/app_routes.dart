part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$SIGN_IN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static const EGOT_SERVICES = _Paths.EGOT_SERVICES;
  static const DEVIS = _Paths.DEVIS;
  static const HOME = _Paths.HOME;
  static const SKETCH_MY_WISHES = _Paths.SKETCH_MY_WISHES;
  static const ATELIER = _Paths.ATELIER;
  static const OUVRAGE = _Paths.OUVRAGE;
  static const MENTIONS_LEGALS = _Paths.MENTIONS_LEGALS;
  static const EGOT_INFOS = _Paths.EGOT_INFOS;
  static const GODZY_LOGO = _Paths.GODZY_LOGO;
  static const PRESENTATION = _Paths.PRESENTATION;
  static const ARCHIVES = _Paths.ARCHIVES;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const REGISTER = _Paths.REGISTER;
  static const ADD_COMPANY = _Paths.ADD_COMPANY;
  static const LIST_COMPANY = _Paths.LIST_COMPANY;
  static const COMPANY_CARD = _Paths.COMPANY_CARD;
  static const USER = _Paths.USER;
}

abstract class _Paths {
  static const EGOT_SERVICES = '/egot-services';
  static const DEVIS = '/devis';
  static const HOME = '/home';
  static const SKETCH_MY_WISHES = '/sketch-my-wishes';
  static const ATELIER = '/atelier';
  static const OUVRAGE = '/ouvrage';
  static const MENTIONS_LEGALS = '/mentions-legals';
  static const EGOT_INFOS = '/egot-infos';
  static const GODZY_LOGO = '/godzy-logo';
  static const PRESENTATION = '/presentation';
  static const ARCHIVES = '/archives';
  static const SIGN_IN = '/sign-in';
  static const REGISTER = '/register';
  static const ADD_COMPANY = '/add-company';
  static const LIST_COMPANY = '/list-company';
  static const COMPANY_CARD = '/company-card';
  static const USER = '/user';
}
