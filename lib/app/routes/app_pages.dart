import 'package:get/get.dart';

import 'package:egot_services/app/modules/Atelier/bindings/atelier_binding.dart';
import 'package:egot_services/app/modules/Atelier/views/atelier_view.dart';
import 'package:egot_services/app/modules/Devis/bindings/devis_binding.dart';
import 'package:egot_services/app/modules/Devis/views/devis_view.dart';
import 'package:egot_services/app/modules/EgotInfos/bindings/egot_infos_binding.dart';
import 'package:egot_services/app/modules/EgotInfos/views/egot_infos_view.dart';
import 'package:egot_services/app/modules/EgotServices/bindings/egot_services_binding.dart';
import 'package:egot_services/app/modules/EgotServices/views/egot_services_view.dart';
import 'package:egot_services/app/modules/GodzyLogo/bindings/godzy_logo_binding.dart';
import 'package:egot_services/app/modules/GodzyLogo/views/godzy_logo_view.dart';
import 'package:egot_services/app/modules/Home/bindings/home_binding.dart';
import 'package:egot_services/app/modules/Home/views/home_view.dart';
import 'package:egot_services/app/modules/MentionsLegals/bindings/mentions_legals_binding.dart';
import 'package:egot_services/app/modules/MentionsLegals/views/mentions_legals_view.dart';
import 'package:egot_services/app/modules/Ouvrage/bindings/ouvrage_binding.dart';
import 'package:egot_services/app/modules/Ouvrage/views/ouvrage_view.dart';
import 'package:egot_services/app/modules/SignIn/bindings/sign_in_binding.dart';
import 'package:egot_services/app/modules/SignIn/views/sign_in_view.dart';
import 'package:egot_services/app/modules/SketchMyWishes/bindings/sketch_my_wishes_binding.dart';
import 'package:egot_services/app/modules/SketchMyWishes/views/sketch_my_wishes_view.dart';
import 'package:egot_services/app/modules/archives/bindings/archives_binding.dart';
import 'package:egot_services/app/modules/archives/views/archives_view.dart';
import 'package:egot_services/app/modules/presentation/bindings/presentation_binding.dart';
import 'package:egot_services/app/modules/presentation/views/presentation_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.EGOT_SERVICES,
      page: () => EgotServicesView(),
      binding: EgotServicesBinding(),
    ),
    GetPage(
      name: _Paths.DEVIS,
      page: () => DevisView(),
      binding: DevisBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SKETCH_MY_WISHES,
      page: () => SketchMyWishesView(),
      binding: SketchMyWishesBinding(),
    ),
    GetPage(
      name: _Paths.ATELIER,
      page: () => AtelierView(),
      binding: AtelierBinding(),
    ),
    GetPage(
      name: _Paths.OUVRAGE,
      page: () => OuvrageView(),
      binding: OuvrageBinding(),
    ),
    GetPage(
      name: _Paths.MENTIONS_LEGALS,
      page: () => MentionsLegalsView(),
      binding: MentionsLegalsBinding(),
    ),
    GetPage(
      name: _Paths.EGOT_INFOS,
      page: () => EgotInfosView(),
      binding: EgotInfosBinding(),
    ),
    GetPage(
      name: _Paths.GODZY_LOGO,
      page: () => GodzyLogoView(),
      binding: GodzyLogoBinding(),
    ),
    GetPage(
      name: _Paths.PRESENTATION,
      page: () => const PresentationView(),
      binding: PresentationBinding(),
    ),
    GetPage(
      name: _Paths.ARCHIVES,
      page: () => const ArchivesView(),
      binding: ArchivesBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
  ];
}
