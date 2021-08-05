import 'package:egot_services/app/models/devis_model.dart';
import 'package:get/get.dart';

class DevisController extends GetxController {
  RxString? username = 'username'.obs;
  RxString? errorText = 'Error'.obs;
  Rxn submitFunc = Rxn<Function>();
  Rxn typesLogementModel = Rxn<TypesLogementModel>();

  final RxInt? id = 0.obs;
  var isMaison = false.obs;
  var isAppartement = false.obs;


  @override
  void onInit() {
    super.onInit();
    debounce(username!, validations, time: const Duration(milliseconds: 500));
  }

  void validations(String val) async {
    if (val.isNotEmpty) {
      if (lengthOK(val) && await available(val)) {
        print('All validations passed, enable submit btn...');
        submitFunc.value = submitFunction();
        errorText!.value = 'null';
      }
    }
  }

  bool lengthOK(String val, {int minLen = 5}) {
    if (val.length < minLen) {
      errorText!.value = 'min. 5 chars';
      return false;
    }
    return true;
  }

  Future<bool> available(String val) async {
    print('Query availability of: $val');
    await Future.delayed(
        const Duration(seconds: 1), () => print('Available query returned'));

    if (val == "Sylvester") {
      errorText!.value = 'Name Taken';
      return false;
    }
    return true;
  }

  void usernameChanged(String val) {
    username!.value = val;
  }

  Future<bool> Function() submitFunction() {
    return () async {
      print('Make database call to create ${username!.value} account');
      await Future.delayed(
          const Duration(seconds: 1), () => print('User account created'));
      return true;
    };
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => id!.value++;
}
