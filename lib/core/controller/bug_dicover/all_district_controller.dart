import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/bug_discover_services.dart';

class AllDistrictController extends GetxController {
  List<dynamic> district = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getDistrictCount();
    super.onInit();
  }

  RxString districtText = 'District'.tr.obs;
  RxInt districtId = 0.obs;

  void onTapSelected(BuildContext con, int id, index) async {
    districtId.value = id;
    Navigator.pop(con);
    districtText.value = district[index].name;
    update();
  }

  bool get loading => _loading.value;
  dynamic getDistrictCount() {
    BugDiscoverServices.getAllDistrict().then((value) {
      district = value;
      // _loading.value = false;
      update();
    });

    return district;
  }
}
