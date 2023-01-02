import 'package:egot_services/app/models/use_x_models.dart';
import 'package:egot_services/app/modules/AddCompany/controllers/add_company_controller.dart';
import 'package:egot_services/app/modules/Register/services/register_services.dart';
import 'package:egot_services/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class ListCompanyController extends GetxController {
  final listController = Get.put<AddCompanyController>(AddCompanyController());

  Rx<List<UserModel>>? userList;

  List<UserModel> get users => userList!.value;

  final count = 0.obs;
  @override
  void onInit() {
    String? uid = Get.find<SignInController>().userID;
    userList!.bindStream(RegisterServices().usersStream(uid!));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
