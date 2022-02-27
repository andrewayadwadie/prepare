import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/animal_controller/nearst_visit_animal_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/animal/visit_animal_screen.dart';
import '../current_location_controller.dart';
 

class AnimalMapCtrl extends GetxController {
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
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  get initialCamPos => initialCameraPosition;
//<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

  Future<void> animateCamera(LocationData _location) async {
    final GoogleMapController controller = await compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        bearing: 192.8334901395799,
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
    dev.log("test location : ${locations.length}");
    NearstVisitAnimalController nearstPoint = Get.put(NearstVisitAnimalController(
        deviceCurrentLocation.currentLat ?? 0.0,
        deviceCurrentLocation.currentLong ?? 0.0));
    dev.log("test point : ${nearstPoint.point.length}");
    for (var i = 0; i < locations.length; i++) {
      marks.add(Marker(
          markerId: MarkerId(locations[i].toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(10),
          position: locations[i],
          onTap: () {
            if (calculateDistance(
                    deviceCurrentLocation.currentLat,
                    deviceCurrentLocation.currentLong,
                    double.parse(nearstPoint.point[i].lat),
                    double.parse(nearstPoint.point[i].long)) <
                200.0) {
              Get.defaultDialog(
                title: " معلومات عن موقع الكلاب الضالة ",
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText:
                    "انت على بعد مسافة ${calculateDistance(deviceCurrentLocation.currentLat, deviceCurrentLocation.currentLong, double.parse(nearstPoint.point[i].lat), double.parse(nearstPoint.point[i].long))} متر من البؤرة ",
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitAnimalScreen(id: nearstPoint.point[i].id,));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 135,
                      height: 40,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "إضافة زيارة ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              );
            } else {
              Get.defaultDialog(
                title: "معلومات عن موقع الكلاب الضالة ",
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText: """
 البلدية :  ${nearstPoint.point[i].cityName}
 الحي :  ${nearstPoint.point[i].districtName}
  التاريخ : ${DateFormat('yyyy-MM-dd : kk:mm').format(DateTime.parse(nearstPoint.point[i].date))}
 
                           """,
                confirm: InkWell(
                  onTap: () {
       
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
                        " الذهاب إلى الموقع  ",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      )),
                ),
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitAnimalScreen(id: nearstPoint.point[i].id,));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "إضافة زيارة   ",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      )),
                ),

                // confirm:
              );
            }
          }));
      update();
    }
  }

  void setPolyLine(List<LatLng> locations) async {
    // List of coordinates to join
    // Initializing PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4",
      PointLatLng(
          locations[1].latitude, locations[1].longitude), // Google Maps API Key
      PointLatLng(locations[0].latitude, locations[0].longitude),

      travelMode: TravelMode.walking,
    );
    dev.log(
        "locations[0].latitude = ${locations[0].latitude} || locations[0].longitude = ${locations[0].longitude} ");
    dev.log(
        "locations[1].latitude = ${locations[1].latitude} || locations[1].longitude = ${locations[1].longitude} ");
    dev.log("result error = ${result.errorMessage}");
    dev.log("result status = ${result.status}");
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      dev.log("result failed ");
    }

    polyline.add(Polyline(
        polylineId: PolylineId(locations[0].latitude.toString()),
        width: 5,
        visible: true,
        color: Colors.red,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: polylineCoordinates));
    update();
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  void onCamMove(LatLng newPos) {
    currentLocation = newPos;
    update();
  }
}
