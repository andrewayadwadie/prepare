import 'package:get/get.dart';

import '../../service/prepration_services.dart';

class CarsCountController extends GetxController {
  List<dynamic> cars = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getCarsCount();
    super.onInit();
  }

  bool get loading => _loading.value;
  List<dynamic> getCarsCount() {
    if (_loading.value == true) {
      PreprationServices.getAllCars().then((value) {
        cars = value;
        _loading.value = false;
        update();
      });
    }
    return cars;
  }
}
