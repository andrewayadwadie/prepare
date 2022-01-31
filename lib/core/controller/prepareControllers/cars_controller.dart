import 'package:get/get.dart';

class CarsController extends GetxController {
  RxString carsCount = "0".obs;
  final RxBool _loading = true.obs;

/*
  @override
  void onInit() {
    // getCarsCount();
    super.onInit();
  }
  */

  bool get loading => _loading.value;
  void getCarsCount(String count) {
    carsCount.value = count;
    update();
  }
}
