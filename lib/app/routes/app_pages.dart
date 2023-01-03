import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../middleswares/auth_middleware.dart';
import '../modules/AddCompany/bindings/add_company_binding.dart';
import '../modules/AddCompany/views/add_company_view.dart';
import '../modules/Atelier/bindings/atelier_binding.dart';
import '../modules/Atelier/views/atelier_view.dart';
import '../modules/Chat/bindings/chat_binding.dart';
import '../modules/Chat/views/chat_view.dart';
import '../modules/CompanyCard/bindings/company_card_binding.dart';
import '../modules/CompanyCard/views/company_card_view.dart';
import '../modules/Devis/bindings/devis_binding.dart';
import '../modules/Devis/views/devis_view.dart';
import '../modules/EgotInfos/bindings/egot_infos_binding.dart';
import '../modules/EgotInfos/views/egot_infos_view.dart';
import '../modules/EgotServices/bindings/egot_services_binding.dart';
import '../modules/EgotServices/views/egot_services_view.dart';
import '../modules/GodzyLogo/bindings/godzy_logo_binding.dart';
import '../modules/GodzyLogo/views/godzy_logo_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ListCompany/bindings/list_company_binding.dart';
import '../modules/ListCompany/views/list_company_view.dart';
import '../modules/MentionsLegals/bindings/mentions_legals_binding.dart';
import '../modules/MentionsLegals/views/mentions_legals_view.dart';
import '../modules/Ouvrage/bindings/ouvrage_binding.dart';
import '../modules/Ouvrage/views/ouvrage_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/SignIn/bindings/sign_in_binding.dart';
import '../modules/SignIn/views/sign_in_view.dart';
import '../modules/SketchMyWishes/bindings/sketch_my_wishes_binding.dart';
import '../modules/SketchMyWishes/views/sketch_my_wishes_view.dart';
import '../modules/archives/bindings/archives_binding.dart';
import '../modules/archives/views/archives_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/avatar_body/bindings/avatar_body_binding.dart';
import '../modules/avatar_body/views/avatar_body_view.dart';
import '../modules/presentation/bindings/presentation_binding.dart';
import '../modules/presentation/views/presentation_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/snap_scroll/bindings/snap_scroll_binding.dart';
import '../modules/snap_scroll/views/snap_scroll_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PRESENTATION;

  static final routes = [
    GetPage(
        name: '/',
        page: () => const RootView(),
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
            opaque: true,
            maintainState: true,
            middlewares: [EnsureAuthMiddleware(), EnsureProfileMiddleware()],
            children: [
              GetPage(
                  name: _Paths.SNAP_SCROLL,
                  page: () => const Center(child: SnapScrollView()),
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
                            name: _Paths.AVATAR_BODY,
                            page: () => const AvatarBodyView(),
                            binding: AvatarBodyBinding(),
                          ),
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
                          GetPage(
                            title: 'Goki works',
                            name: _Paths.GODZY_LOGO,
                            page: () => GodzyLogoView(),
                            binding: GodzyLogoBinding(),
                          ),
                        ]),
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
              GetPage(
                name: _Paths.CHAT,
                page: () => const ChatView(),
                binding: ChatBinding(),
              ),
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
