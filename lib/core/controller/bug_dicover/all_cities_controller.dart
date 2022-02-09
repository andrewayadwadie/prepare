import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllCitiesController extends GetxController {
  List<dynamic> cities = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getCitiesCount();
    super.onInit();
  }

  RxString cityText = "إختر إسم البلدية ".obs;

  RxInt cityId = 0.obs;

  void onTapSelected(BuildContext con, int id,index) {
    cityId.value = id;
    Navigator.pop(con);

    cityText.value = cities[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getCitiesCount() {
    if (_loading.value == true) {
      BugDiscoverServices.getAllCities().then((value) {
        cities = value;
        _loading.value = false;
        update();
      });
    }
    return cities;
  }
}
