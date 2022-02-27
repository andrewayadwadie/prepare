import 'dart:developer';

import 'package:get/get.dart';

class Evaluate extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   evaluateList.length = evaluateList.length + 1;
  // }

  List evaluateList = [].obs;
  // List<String> item = [];
  // List<String> recommendation = [];

  List<dynamic> data = [];

  void addData({String description = "", String item = ""}) {
    data.add({"Item": item, "Description": description});
    update();
  }

  void increaseList() {
    evaluateList.length++;
    update();
  }

  void decreaseList(index) {
    log("index from controller $index");
    evaluateList.removeAt(index);
    update();
  }
}
