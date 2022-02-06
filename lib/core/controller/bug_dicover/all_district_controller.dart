import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllDistrictController extends GetxController {
  // AllDistrictController(this.id);
  // final RxInt id;

  List<dynamic> district = [].obs;
  final RxBool _loading = true.obs;

  // @override
  // void onInit() {
  //   getDistrictCount(disId :id.value);
  //   super.onInit();
  // }

  RxString districtText = "إختر إسم الحي ".obs;
  RxInt districtId = 0.obs;

  void onTapSelected(BuildContext con, int id, index) async {
    districtId.value = id;
    Navigator.pop(con);
    districtText.value = district[index].name;
    update();
  }

  bool get loading => _loading.value;
  dynamic getDistrictCount({required int disId}) {
    log("disId : $disId");
    // if (_loading.value == true) {
    log("disId : $disId");
    BugDiscoverServices.getAllDistrict(disId).then((value) {
      district = value;
      log("district return value is : $value");
      // _loading.value = false;
      update();
    });
    // }
    return district;
  }
}
