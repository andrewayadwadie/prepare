
import 'package:get/get.dart';

class CarsController extends GetxController {
  List carsCount = [];

  List<Map<String, dynamic>> carObjectList = [];

  void getCarsCount(int count) {
    carsCount.add(count);
    update();
  }

  void addCarObject(int id, int count) {
    carObjectList.add({"VehicleId": id, "Count": count});
    update();
  }

  int getCarsSum(List carList) {
    int sum = 0;
    for (int i = 0; i < carList.length; i++) {
      sum += carList[i] as int;
    }
    // log("CAR 1 : ${carsCount[0]}");

    return sum;
  }
}
