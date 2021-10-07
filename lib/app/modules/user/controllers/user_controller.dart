import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/user/providers/user_provider.dart';
import 'package:get/get.dart';

class UserController extends SuperController<List<UserModel>> {
  final UserProvider? userProvider;
  UserController({required this.userProvider});

  @override
  void onInit() {
    findAllUsers();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  void findAllUsers() {
    userProvider!.getAllUsers().then((result) {
      List<UserModel>? data = result.body;

      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    }
    );
  }
}
