import 'package:get/get.dart';

class DevicesController extends GetxController {
  RxString devicesCount = "0".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  void getdevicesCount(String count) {
    devicesCount.value = count;
    update();
  }
}
