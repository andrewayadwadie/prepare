import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllDistrictController extends GetxController {
  AllDistrictController(this.id);
  final int id;

  List<dynamic> district = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getDistrictCount(id);
    super.onInit();
  }

  String districtText = "إختر إسم الحي ";

  int districtId = 0;

  void onTapSelected(BuildContext con, int id) {
    districtId = id;
    Navigator.pop(con);

    districtText = district[id - 1].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getDistrictCount(int id) {
    if (_loading.value == true) {
      BugDiscoverServices.getAllDistrict(id).then((value) {
        district = value;
        _loading.value = false;
        update();
      });
    }
    return district;
  }
}
