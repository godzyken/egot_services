import 'package:get/get.dart';

import 'package:egot_services/app/middleswares/auth_middleware.dart';
import 'package:egot_services/app/modules/AddCompany/bindings/add_company_binding.dart';
import 'package:egot_services/app/modules/AddCompany/views/add_company_view.dart';
import 'package:egot_services/app/modules/Atelier/bindings/atelier_binding.dart';
import 'package:egot_services/app/modules/Atelier/views/atelier_view.dart';
import 'package:egot_services/app/modules/CompanyCard/bindings/company_card_binding.dart';
import 'package:egot_services/app/modules/CompanyCard/views/company_card_view.dart';
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
import 'package:egot_services/app/modules/ListCompany/bindings/list_company_binding.dart';
import 'package:egot_services/app/modules/ListCompany/views/list_company_view.dart';
import 'package:egot_services/app/modules/MentionsLegals/bindings/mentions_legals_binding.dart';
import 'package:egot_services/app/modules/MentionsLegals/views/mentions_legals_view.dart';
import 'package:egot_services/app/modules/Ouvrage/bindings/ouvrage_binding.dart';
import 'package:egot_services/app/modules/Ouvrage/views/ouvrage_view.dart';
import 'package:egot_services/app/modules/Register/bindings/register_binding.dart';
import 'package:egot_services/app/modules/Register/views/register_view.dart';
import 'package:egot_services/app/modules/SignIn/bindings/sign_in_binding.dart';
import 'package:egot_services/app/modules/SignIn/views/sign_in_view.dart';
import 'package:egot_services/app/modules/SketchMyWishes/bindings/sketch_my_wishes_binding.dart';
import 'package:egot_services/app/modules/SketchMyWishes/views/sketch_my_wishes_view.dart';
import 'package:egot_services/app/modules/archives/bindings/archives_binding.dart';
import 'package:egot_services/app/modules/archives/views/archives_view.dart';
import 'package:egot_services/app/modules/auth/bindings/auth_binding.dart';
import 'package:egot_services/app/modules/auth/views/auth_view.dart';
import 'package:egot_services/app/modules/presentation/bindings/presentation_binding.dart';
import 'package:egot_services/app/modules/presentation/views/presentation_view.dart';
import 'package:egot_services/app/modules/root/bindings/root_binding.dart';
import 'package:egot_services/app/modules/root/views/root_view.dart';
import 'package:egot_services/app/modules/snap_scroll/bindings/snap_scroll_binding.dart';
import 'package:egot_services/app/modules/snap_scroll/views/snap_scroll_view.dart';
import 'package:egot_services/app/modules/user/bindings/user_binding.dart';
import 'package:egot_services/app/modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: '/',
        page: () => RootView(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
            name: _Paths.HOME,
            title: null,
            page: () => const HomeView(),
            binding: HomeBinding(),
            participatesInRootNavigator: true,
            preventDuplicates: true,
            // opaque: true,
            // maintainState: true,
            middlewares: [EnsureAuthMiddleware(), EnsureProfileMiddleware()],
            children: [
              GetPage(
                  name: _Paths.SNAP_SCROLL,
                  page: () => SnapScrollView(),
                  binding: SnapScrollBinding(),
                  children: [
                    GetPage(
                        title: 'EGOTE Services',
                        name: _Paths.EGOT_SERVICES,
                        page: () => EgotServicesView(),
                        binding: EgotServicesBinding(),
                        transition: Transition.zoom,
                        children: [
                          GetPage(
                            title: 'Devis',
                            name: _Paths.DEVIS,
                            page: () => const DevisView(),
                            binding: DevisBinding(),
                          ),
                        ]),
                    GetPage(
                        title: 'Atelier',
                        name: _Paths.ATELIER,
                        page: () => AtelierView(),
                        binding: AtelierBinding(),
                        children: [
                          GetPage(
                            title: 'Sketch My Wishes',
                            name: _Paths.SKETCH_MY_WISHES,
                            page: () => SketchMyWishesView(),
                            binding: SketchMyWishesBinding(),
                          ),
                        ]),
                    GetPage(
                        title: 'Presentation',
                        name: _Paths.PRESENTATION,
                        page: () => const PresentationView(),
                        binding: PresentationBinding(),
                        children: [
                          GetPage(
                            title: 'Mention Legals',
                            name: _Paths.MENTIONS_LEGALS,
                            page: () => MentionsLegalsView(),
                            binding: MentionsLegalsBinding(),
                          ),
                          GetPage(
                              title: 'Egote Infos',
                              name: _Paths.EGOT_INFOS,
                              page: () => EgotInfosView(),
                              binding: EgotInfosBinding(),
                              children: [
                                GetPage(
                                  title: 'Archives',
                                  name: _Paths.ARCHIVES,
                                  page: () => const ArchivesView(),
                                  binding: ArchivesBinding(),
                                ),
                                GetPage(
                                  title: 'Ouvrages',
                                  name: _Paths.OUVRAGE,
                                  page: () => OuvrageView(),
                                  binding: OuvrageBinding(),
                                ),
                              ]),
                        ]),
                    GetPage(
                      title: 'Goki works',
                      name: _Paths.GODZY_LOGO,
                      page: () => GodzyLogoView(),
                      binding: GodzyLogoBinding(),
                    ),
                    GetPage(
                        title: 'Company Card',
                        name: _Paths.COMPANY_CARD,
                        page: () => const CompanyCardView(),
                        binding: CompanyCardBinding(),
                        children: [
                          GetPage(
                            title: 'Add your Company',
                            name: _Paths.ADD_COMPANY,
                            page: () => const AddCompanyView(),
                            binding: AddCompanyBinding(),
                          ),
                          GetPage(
                            title: 'List of Companies',
                            name: _Paths.LIST_COMPANY,
                            page: () => const ListCompanyView(),
                            binding: ListCompanyBinding(),
                          ),
                        ]),
                  ]),
            ],
            popGesture: true,
          ),
          GetPage(
              title: 'Authentication',
              name: _Paths.AUTH,
              page: () => AuthView(),
              binding: AuthBinding(),
              children: [
                GetPage(
                  title: 'Profile',
                  name: _Paths.USER,
                  page: () => const UserView(),
                  binding: UserBinding(),
                ),
                GetPage(
                  title: 'Sign in',
                  name: _Paths.SIGN_IN,
                  page: () => const SignInView(),
                  binding: SignInBinding(),
                ),
                GetPage(
                  title: 'Register',
                  name: _Paths.REGISTER,
                  page: () => const RegisterView(),
                  binding: RegisterBinding(),
                ),
              ]),
        ]),
  ];
}
