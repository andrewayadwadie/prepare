import 'package:get/get.dart';

class PestsidesController extends GetxController {
  List pestsidesCount = [];

  List<Map<String, dynamic>> pestSideObjectList = [];


  void getpestsidesCount(int count) {
    pestsidesCount.add(count);
    update();
  }

   void addPestSideObject(int id, int count) {
    pestSideObjectList.add({"ExterminatorId": id, "Quantity": count});
    update();
  }

  int getPestSideSum(List pestSideList) {
    int sum = 0;
    for (int i = 0; i < pestSideList.length; i++) {
      sum += pestSideList[i] as int;
    }
    return sum;
  }
}
