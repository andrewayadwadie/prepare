import 'package:get/get.dart';

class CarsController extends GetxController {
  List carsCount = [];

  void getCarsCount(int count) {
    carsCount.add(count);
    update();
  }

  int getCarsSum(List carList) {
    int sum = 0;
    for (int i = 0; i < carList.length; i++) {
      sum += carList[i] as int;
    }
    return sum;
  }
}
