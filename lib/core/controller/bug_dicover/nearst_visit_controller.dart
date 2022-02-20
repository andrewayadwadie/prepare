//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class NearstBugDiscoverVisit extends GetxController {
  List<dynamic> point = [].obs;
  final RxBool _loading = true.obs;
  final double lat;
  final double long;

  NearstBugDiscoverVisit(this.lat, this.long);

  @override
  void onInit() {
    getPointCount(lat, long);
    super.onInit();
  }

  bool get loading => _loading.value;
  dynamic getPointCount(double lat, double long) {
    if (_loading.value == true) {
      BugDiscoverServices.getNearstBugDiscoverVisit(lat, long).then((value) {
        point = value;
        _loading.value = false;
        update();
      });
    }
    return point;
  }
}
