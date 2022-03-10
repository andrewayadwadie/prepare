import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/service/bug_discover_services.dart';

class AllFlyNoteController extends GetxController {
  List<dynamic> flyNote = [].obs;
  final RxBool _loading = true.obs;

  @override
  void onInit() {
    getFlyNoteCount();
    super.onInit();
  }

  String flyNoteText = "نوع الملاحظة";

  int flyNoteId = 0;

  void onTapSelected(BuildContext con, int id,index) {
    flyNoteId = id;
    Navigator.pop(con);

    flyNoteText = flyNote[index].name;

    update();
  }

  bool get loading => _loading.value;
  dynamic getFlyNoteCount() {
    if (_loading.value == true) {
      BugDiscoverServices.getAllFlyNotes().then((value) {
        flyNote = value;
        _loading.value = false;
        update();
      });
    }
    return flyNote;
  }
}
