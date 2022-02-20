//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/daily_work_services.dart';

class DailyWorkPointController extends GetxController {
  List<dynamic> points = [].obs;

  @override
  void onInit() {
    getPointCount();
    super.onInit();
  }

  dynamic getPointCount() {
    DailyWorkServices.getAllPoint().then((value) {
      points = value;

      update();
    });

    return points;
  }
}
