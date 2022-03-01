

import 'dart:developer';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_map_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/daily_work/service/dailty_work_service.dart';
import 'package:prepare/view/mapbox/controller/mapbox_controller.dart';

class IsolateController extends GetxController{


    MapBoxController box = Get.put(MapBoxController());


///////////////////////////////////////////////////////////////////////////////////
//<<<<<<<<<<<<<<<<<<<<<<<<<<<Isolate>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  Isolate? geek;

static void workWithGoogleIsolate(SendPort sendPort) {
  CurrentLocationController currentLocation =
    Get.put(CurrentLocationController());
DailyWorkMapCtrl googleMap = Get.put(DailyWorkMapCtrl());
InternetController nett = Get.put(InternetController());
  currentLocation.location.onLocationChanged.listen((event) {
    currentLocation.location.getLocation().then((curent) {
      if (googleMap.calculateDistance(curent.latitude, curent.longitude,
              event.latitude, event.longitude) >
          5.0) {
        googleMap.isTaskDone();
        log(" speed = ${event.speed}");
        log("Date = ${DateTime.now()}");
        log("current = ${curent.latitude},${curent.longitude}");
        log("event = ${event.latitude},${event.longitude}");
        log("distance = ${googleMap.calculateDistance(curent.latitude, curent.longitude, event.latitude, event.longitude)}");
        googleMap.setnewPath(
            LatLng(
              curent.latitude ?? 0.0,
              curent.longitude ?? 0.0,
            ),
            LatLng(event.latitude ?? 0.0, event.longitude ?? 0.0));
        nett.checkInternet().then((val) {
          if (val) {
            DailyWorkService.addLine(
                    date: DateTime.now().toString(),
                    lat: event.latitude.toString(),
                    long: curent.longitude.toString(),
                    speed: event.speed.toString())
                .then((value) {
              if (value == 401) {
                Get.offAll(const LoginScreen());
              } else if (value == 400) {
                Get.snackbar("مشكلة", "يوجد مشكلة فى ارسال البيانات ");
              } else if (value == 200) {
                log("status = 200");
                return;
              }
            });
          }
        });
      }
    });
  });
}

}