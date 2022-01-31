import 'package:get/get.dart';

class DevicesController extends GetxController {
  List devicesCount = [];

  void getdevicesCount(int count) {
    devicesCount.add(count);
    update();
  }

  int getDeviceSum(List deviceList) {
    int sum = 0;
    for (int i = 0; i < deviceList.length; i++) {
      sum += deviceList[i] as int;
    }
    return sum;
  }
}
