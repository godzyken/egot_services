import 'package:egot_services/app/modules/Register/bindings/register_binding.dart';
import 'package:egot_services/app/modules/Register/controllers/register_controller.dart';
import 'package:egot_services/app/modules/auth/controllers/auth_controller.dart';
import 'package:egot_services/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  static final middlewares = [
    GetMiddleware(priority: 2),
    GetMiddleware(priority: 5),
    GetMiddleware(priority: 4),
    GetMiddleware(priority: -8),
  ];
  AuthController? authServices;

  int? get priority => 2;

  var isSignIn = false.obs;
  @override
  RouteSettings? redirect(String? route) {
    print('route: $route');
    return isSignIn.value == authServices?.isSignIn.isFalse || route == Routes.REGISTER
        ? null
        : RouteSettings(name: Routes.REGISTER, arguments: authServices?.isSignIn.value);
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = AuthController();
    if (!authServices.isSignIn.value) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }

  @override
  void onPageDispose() {
    super.onPageDispose();
  }

  @override
  Widget onPageBuilt(Widget? page) {
    print('bindings are ready');
    return page!;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) => page;

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    final authService = AuthController();
    if (authService.isSignIn.value) {
      bindings!.add(RegisterBinding());
    }
    return bindings;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page!.copy(
      name: '/home',
      settings: redirect('/register'),
      middlewares: middlewares,
      binding: RegisterBinding(),
      arguments: authServices?.user,
      popGesture: true,
    );
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authServices = Get.put(AuthController());

    if (authServices.isSignIn.value) {
      //NEVER navigate to auth screen, when user is already authed
      //return null;

      //OR redirect user to another screen
      return GetNavConfig.fromRoute(Routes.COMPANY_CARD);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureProfileMiddleware extends GetMiddleware {
  @override
  int? get priority => 4;

  var isProfileSet = false.obs;

  @override
  RouteSettings? redirect(String? route) {
    final authServices = AuthController();
    if (isProfileSet.value == authServices.isSignIn.isFalse) {
      print('redirecte to: ${authServices.isSignIn.value}');
      return const RouteSettings(name: Routes.HOME);
    }
  }


}
