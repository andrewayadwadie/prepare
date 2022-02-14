//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/epicenter_services.dart';

class AllNearstPointsController extends GetxController {
  List<dynamic> point = [].obs;
  final RxBool _loading = true.obs;
  final double lat;
  final double long;

  AllNearstPointsController( this.lat, this.long);

  @override
  void onInit() {
    getPointCount(lat, long);
    super.onInit();
  }
/*
  String pointText = "إختر نوع الحشرة";

  int pointId = 0;

  void onTapSelected(BuildContext con, int id, int index) {
    pointId = id;
    Navigator.pop(con);

    pointText = point[index].name;

    update();
  }
*/
  bool get loading => _loading.value;
  dynamic getPointCount(double lat, double long) {
    if (_loading.value == true) {
      EpicenterServices.getNearstEpicenterVisit(lat, long).then((value) {
        point = value;
        _loading.value = false;
        update();
      });
    }
    return point;
  }
}
