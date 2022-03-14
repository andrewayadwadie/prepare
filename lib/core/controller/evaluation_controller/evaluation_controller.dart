import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Evaluate extends GetxController {
  List evaluateList = [].obs;
  late List<TextEditingController> textEditItemList = <TextEditingController>[];
  late List<TextEditingController> textEditDisList = <TextEditingController>[];

  void addItem(int index, {String? item}) {
    evaluateList[index]["Item"] = item;
    textEditItemList[index].value.text == item;
    update();
  }

  void addDescription(int index, {String? dis}) {
    evaluateList[index]["Description"] = dis;
    textEditDisList[index].value.text == dis;
    update();
  }

  void increaseList() {
    evaluateList.add({"Item": "", "Description": ""});
    textEditItemList.add(TextEditingController());
    textEditDisList.add(TextEditingController());
    update();
  }

  void decreaseList(index) {
    log("index from controller $index");
    evaluateList.removeAt(index);
    textEditItemList.removeAt(index);
    textEditDisList.removeAt(index);
    update();
  }
}
