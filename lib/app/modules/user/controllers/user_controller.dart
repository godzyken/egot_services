import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/user/providers/user_provider.dart';

class UserController extends SuperController<List<UserModel>> {
  UserController(this.userId);

  final userProvider = UserProvider();
  final Rx<UserModel> _userModel = UserModel().obs;
  String? userId;

  var running = false.obs;

  UserModel? get user => _userModel.value;

  set user(UserModel? value) => _userModel.value = value!;

  Stream<UserModel?> userStream() async* {
    while (running.value) {
      await findAllUsers();

      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    findAllUsers();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

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

  void clear() {
    _userModel.value = UserModel();

    update();
  }

  findAllUsers() async {
    userProvider.getAllUsers().then((result) {
      List<UserModel>? data = result.sublist(listeners);

      change(data, status: RxStatus.success());

      update();

      return data.toList();
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
      return err;
    });
  }

  updateUserCompanyEmail(String? newValue) {
    _userModel.update((userModel) {
      userModel!.email = newValue;
    });

    update();

    if (kDebugMode) {
      print('New company name: ${_userModel.value.email}');
    }
  }

  updateUserCompanyName(String? newValue) {
    _userModel.update((userModel) {
      userModel!.companyName = newValue;
    });

    update();

    if (kDebugMode) {
      print('New company name: ${_userModel.value.companyName}');
    }
  }

  updateUserCompanyActivity(String? newValue) {
    _userModel.update((userModel) {
      userModel!.activity = newValue;
    });

    update();

    if (kDebugMode) {
      print('New company activity: ${_userModel.value.activity}');
    }
  }

  updateUserCompanySpeciality(String? newValue) {
    _userModel.update((userModel) {
      userModel!.specialisation = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New company sp??ciality: ${_userModel.value.specialisation}');
    }
  }

  updateUserCompanyIdentity(String? newValue) {
    _userModel.update((userModel) {
      userModel!.matriculation = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New company identity: ${_userModel.value.matriculation}');
    }
  }

  updateUserCompanyLocation(String? newValue) {
    _userModel.update((userModel) {
      userModel!.location = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New company localisation: ${_userModel.value.location}');
    }
  }

  updateUserCompanyStatus(String? newValue) {
    _userModel.update((userModel) {
      userModel!.status = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New company status: ${_userModel.value.status}');
    }
  }

  updateUserCompanyLength(int? newValue) {
    _userModel.update((userModel) {
      userModel!.length = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New number of personnes: ${_userModel.value.length}');
    }
  }

  updateUserCompanyAssurance(String? newValue) {
    _userModel.update((userModel) {
      userModel!.assurance = newValue;
    });

    _userModel.refresh();

    update();

    if (kDebugMode) {
      print('New company assurance: ${_userModel.value.assurance}');
    }
  }
}
