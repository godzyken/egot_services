import 'package:get/get.dart';

import '../modules/Chat/bindings/chat_binding.dart';
import '../modules/Chat/views/chat_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/SignIn/bindings/sign_in_binding.dart';
import '../modules/SignIn/views/sign_in_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHAT;

  static final routes = [
    GetPage(
        name: '/',
        page: () => const RootView(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          /*GetPage(
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
          ),*/
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
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
