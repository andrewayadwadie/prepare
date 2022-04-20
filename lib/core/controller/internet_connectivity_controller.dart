import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../utils/style.dart';

class InternetController extends GetxController{


Future<bool> checkInternet() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (hasInternet == false) {
      showSimpleNotification(
       const Text(
          "لا يوجد إتصال بالانترنت",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        background: redColor,
      );
    update();
      return false;
    }
  update();
    return true;
  }



}