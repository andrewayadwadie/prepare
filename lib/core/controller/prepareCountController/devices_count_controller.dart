import 'package:get/get.dart';

import '../../service/prepration_services.dart';

class DevicesCountController extends GetxController {
  List<dynamic> devices = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getDevicesCount();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getDevicesCount() {
    if (_loading.value == true) {
      PreprationServices.getAllDevices().then((value) {
        devices = value;
        _loading.value = false;
        update();
      });
    }
    return devices;
  }
}
