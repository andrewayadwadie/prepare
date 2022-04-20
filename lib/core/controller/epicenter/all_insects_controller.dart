import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/epicenter_services.dart';

class AllInsectsController extends GetxController {
  List<dynamic> insects = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getInsectsCount();
    super.onInit();
  }

  String insectsText = 'Type of insect'.tr;

  int insectsId = 0;

  void onTapSelected(BuildContext con, int id,int index) {
    insectsId = id;
    Navigator.pop(con);
    log("insects List : ${insects.length}");
    log("insects id : $id");
    insectsText = insects[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getInsectsCount() {
    if (_loading.value == true) {
      EpicenterServices.getAllInsects().then((value) {
        insects = value;
        _loading.value = false;
        update();
      });
    }
    return insects;
  }
}
