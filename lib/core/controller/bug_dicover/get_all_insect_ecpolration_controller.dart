import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class GetUserInsectExplorationsController extends GetxController {
  List<dynamic> insectExplorations = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getInsectExplorationsCount();
    super.onInit();
  }

  String insectExplorationsText = "إختر نوع الإستكشاف الحشري";

  int insectExplorationsId = 0;

  void onTapSelected(BuildContext con, int id, int index) {
    insectExplorationsId = id;
    Navigator.pop(con);

    insectExplorationsText = insectExplorations[index].street;

    update();
  }

  bool get loading => _loading.value;
  dynamic getInsectExplorationsCount() {
    if (_loading.value == true) {
      BugDiscoverServices.getAllInsectExploration().then((value) {
        insectExplorations = value;
        _loading.value = false;
        update();
      });
    }
    return insectExplorations;
  }
}
