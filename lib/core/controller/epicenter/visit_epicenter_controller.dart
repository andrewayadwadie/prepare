import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/all_epicenter_services.dart';
 
class VisitEpicenterController extends GetxController {
  List<dynamic> epicenter = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getEpicenterCount();
    super.onInit();
  }

  String epicenterText = "إختر البؤرة";

  int epicenterId = 0;

  void onTapSelected(BuildContext con, int id,int index) {
    epicenterId = id;
    Navigator.pop(con);

    epicenterText = epicenter[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getEpicenterCount() {
    if (_loading.value == true) {
      AllEpicenterServices.getAllEpicenter().then((value) {
        epicenter = value;
        _loading.value = false;
        update();
      });
    }
    return epicenter;
  }
}
