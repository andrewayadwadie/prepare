import 'package:get/get.dart';

class DevicesController extends GetxController {
  List devicesCount = [];
List<Map<String, dynamic>> devicesObjectList = [];
  void getdevicesCount(int count) {
    devicesCount.add(count);
    update();
  }

 void addDevicesObject(int id, int count) {
    devicesObjectList.add({"DeviceId": id, "Count": count});
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
