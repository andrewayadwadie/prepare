import 'package:get/get.dart';

import 'package:prepare/core/service/prepration_services.dart';

class UserPreprationController extends GetxController {
  UserPreprationController(
    this.id,
  );
  final int? id;

  dynamic data ;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getPreprationData(id!);
    super.onInit();
  }

  bool get loading => _loading.value;
  dynamic getPreprationData(int id) {
    if (_loading.value == true) {
      PreprationServices.getUserPrepration(id).then((value) {
        data = value;
        _loading.value = false;
        update();
      });
    }
    return data;
  }
}
