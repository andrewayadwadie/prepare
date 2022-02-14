import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/epicenter/all_nearst_point_controllerd.dart';
import 'package:prepare/utils/style.dart';

import '../current_location_controller.dart';

class MapCtrl extends GetxController {
  CurrentLocationController deviceCurrentLocation =
      Get.put(CurrentLocationController());

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(30.0862704, 31.3415012),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> compeleteController = Completer();
  LatLng currentLocation = initialCameraPosition.target;
  //BitmapDescriptor? _locationIcon;

  Marker? mark;
  Set<Marker> marks = {};
  Set<Polyline> polyline = {};

  get initialCamPos => initialCameraPosition;
//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  Future<void> animateCamera(LocationData _location) async {
    final GoogleMapController controller = await compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 16.4746);

    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPostion));
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>//

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  void setMarker(LatLng _location) {
    Marker newMarker = Marker(
        markerId: MarkerId(_location.toString()),
        icon: BitmapDescriptor.defaultMarker,
        // icon: _locationIcon,
        position: _location,
        infoWindow: InfoWindow(
            title: "Info",
            snippet:
                "${currentLocation.latitude}, ${currentLocation.longitude}"),
        onTap: () {});

    mark = newMarker;
    update();
  }

//<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  void setMarkers(List<LatLng> locations) {
    AllNearstPointsController nearstPoint = Get.put(AllNearstPointsController(
        deviceCurrentLocation.currentLat ?? 0.0,
        deviceCurrentLocation.currentLong ?? 0.0));

    for (var i = 0; i < locations.length; i++) {
      marks.add(Marker(
          markerId: MarkerId(locations[i].toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: locations[i],
          onTap: () {
            if (calculateDistance(
                    deviceCurrentLocation.currentLat,
                    deviceCurrentLocation.currentLong,
                    double.parse(nearstPoint.point[i].lat),
                    double.parse(nearstPoint.point[i].long)) <
                200.0) {
              Get.defaultDialog(
                title: "معلومات عن البؤرة ",
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText:
                    "انت على بعد مسافة ${calculateDistance(deviceCurrentLocation.currentLat, deviceCurrentLocation.currentLong, double.parse(nearstPoint.point[i].lat), double.parse(nearstPoint.point[i].long))} متر من البؤرة ",
                cancel: Container(
                    alignment: Alignment.center,
                    width: 135,
                    height: 40,
                    decoration: BoxDecoration(
                        color: lightPrimaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "إضافة زيارة بؤرة ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                onCancel: () {},
              );
            } else {
              Get.defaultDialog(
                title: "معلومات عن البؤرة ",
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText: """
  اسم البؤرة : ${nearstPoint.point[i].name}
  نوع الحشرة :  ${nearstPoint.point[i].insectName}
  التاريخ : ${DateTime.parse(nearstPoint.point[i].date)}
  إسم الحي :  ${nearstPoint.point[i].districtName}
  إسم البلدية :  ${nearstPoint.point[i].cityName}
  الملاحظات :  ${nearstPoint.point[i].recommendation}
 
                           """,
                confirm: InkWell(
                  onTap: () {
                    dev.log("hi");
                    Get.back();
                    setPolyLine([
                      LatLng(double.parse(nearstPoint.point[i].lat),
                          double.parse(nearstPoint.point[i].long)),
                      LatLng(
                        deviceCurrentLocation.currentLat,
                        deviceCurrentLocation.currentLong,
                      )
                    ]);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 95,
                      height: 40,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        " الذهاب إلى البؤرة ",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      )),
                ),
                cancel: Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                        color: lightPrimaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text(
                      "زيارة البؤرة",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),

                onCancel: () {},

                // confirm:
              );
            }
          }));
      update();
    }
  }

  void setPolyLine(List<LatLng> locations) {
 
    for (var i = 0; i < locations.length; i++) {
      polyline.add(Polyline(
          polylineId: PolylineId(locations[i].toString()),
          width: 5,
          visible: true,
          color: Colors.red,
          consumeTapEvents: true,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: [
            locations[i],
            LatLng(deviceCurrentLocation.currentLat ?? 0.0,
                deviceCurrentLocation.currentLong ?? 0.0)
          ]));
      update();
    }
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  void onCamMove(LatLng newPos) {
    currentLocation = newPos;
    update();
  }
}
