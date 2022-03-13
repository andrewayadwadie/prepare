import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllFlyTypeController extends GetxController {
  List<dynamic> flyType = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getFlyTypeCount();
    super.onInit();
  }

  String flyTypeText = 'Site type'.tr;

  int flyTypeId = 0;

  void onTapSelected(BuildContext con, int id,int index) {
    flyTypeId = id;
    Navigator.pop(con);

    flyTypeText = flyType[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getFlyTypeCount() {
    if (_loading.value == true) {
      BugDiscoverServices.getAllFlyTypes().then((value) {
        flyType = value;
        _loading.value = false;
        update();
      });
    }
    return flyType;
  }
}
