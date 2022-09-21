import 'package:get/get.dart';

import '../../../core/db/auth_shared_preferences.dart';
import '../../../core/service/auth_services.dart';
import '../../../utils/style.dart';
import '../../home/home_screen.dart';

class LoginController extends GetxController {
  bool vis = true;

  RxBool loading = true.obs;

  void sendLoginData({required String? email, required String? password}) {
    loading.value = false;
    AuthServices.login(email: email ?? "", password: password ?? "")
        .then((res) {
      //! success
      if (res.runtimeType == List) {
        loading.value = true;
        SharedPref.setTokenValue(res[0].toString());
        SharedPref.setExpireDateValue(res[1].toString());
        SharedPref.setRoleValue(res[2].toString());
        SharedPref.setUserNameValue(res[3].toString());
//Todo : this condition temproray still work in new api
        if (SharedPref.getRoleValue() == "Driver") {
          Get.offAll(() => const HomeScreen());
        }
        //!Error
      } else if (res.runtimeType == String) {
        loading.value = true;
        Get.defaultDialog(
          title: "Error",
          middleText: "something went wrong",
          onConfirm: () => Get.back(),
          confirmTextColor: whiteColor,
          buttonColor: redColor,
          backgroundColor: whiteColor,
        );
      }
    });
  }

  void eyetToggle() {
    vis = !vis;
    update();
  }
}
