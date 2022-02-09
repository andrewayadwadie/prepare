import 'dart:developer';

import 'package:get/get.dart';

class SiteStatusController extends GetxController{
bool? isNegative = true;
  void onChanged(bool? value){
    isNegative = value;
    log("isNegative : $isNegative");
    update();
  }
}