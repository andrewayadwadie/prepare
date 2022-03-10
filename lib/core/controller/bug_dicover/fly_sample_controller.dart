import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllFlySampleController extends GetxController {
  List<dynamic> flySample = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getFlySampleCount();
    super.onInit();
  }


  String flySampleText = "نوع العينة";

  int flySampleId = 0;

  void onTapSelected(BuildContext con, int id,int index) {
    flySampleId = id;
    Navigator.pop(con);

    flySampleText = flySample[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getFlySampleCount() {
    if (_loading.value == true) {
      BugDiscoverServices.getAllFlySampleTypes().then((value) {
        flySample = value;
        _loading.value = false;
        update();
      });
    }
    return flySample;
  }
}
