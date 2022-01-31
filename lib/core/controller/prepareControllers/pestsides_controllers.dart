import 'package:get/get.dart';

class PestsidesController extends GetxController {
  RxString pestsidesCount = "0".obs;
  final RxBool _loading = true.obs;

  bool get loading => _loading.value;
  void getpestsidesCount(String count) {
    pestsidesCount.value = count;
    update();
  }
}
