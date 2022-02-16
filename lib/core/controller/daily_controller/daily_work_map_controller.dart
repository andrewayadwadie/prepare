import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../current_location_controller.dart';

class DailyWorkMapCtrl extends GetxController {
  CurrentLocationController deviceCurrentLocation =
      Get.put(CurrentLocationController());

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(30.0862704, 31.3415012),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> compeleteController = Completer();
  LatLng currentLocation = initialCameraPosition.target;
  //BitmapDescriptor? _locationIcon;

  //Marker? mark;

  //Set<Marker> marks = {};
  // Set<Polyline> polyline = {};
  // List of coordinates to join
  //List<LatLng> polylineCoordinates = [];
  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  //<<<<<<<<<<<<<<<<<<<<<<<<current path data>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  Marker currentMark = Marker(
      markerId: const MarkerId("Mark1"),
      icon: BitmapDescriptor.defaultMarker,
      // icon: _locationIcon,
      position: const LatLng(30.0862704, 31.3415012),
      infoWindow: const InfoWindow(
          title: "Info", snippet: "${30.0862704}, ${31.3415012}"),
      onTap: () {});
  Set<Polyline> allPolyLine = {};
  List<LatLng> carCurrentPath = [];
  //<<<<<<<<<<<<<origin path >>>>>>>>>>//
  List<LatLng> originPath = [
    const LatLng(30.081654223476963, 31.35709440794601),
    const LatLng(30.083733591782217, 31.32155963683227),
    const LatLng(30.062862216334263, 31.285511581583222),
    const LatLng(30.033366647389016, 31.26689507392588),
    const LatLng(29.99217555011128, 31.282938583489916),
    const LatLng(29.99141498222869, 31.233676507716712),
    const LatLng(29.989934120992736, 31.149554373868867),
    const LatLng(30.021756275326613, 31.165855640440057),
    const LatLng(30.062250684916698, 31.174272633191723),
    const LatLng(30.121661245415556, 31.14124346609501)
  ];

  List<LatLng> testPath = [
    const LatLng(30.081654223476963, 31.35709440794601),
    const LatLng(30.083733591782217, 31.32155963683227),
    const LatLng(30.062862216334263, 31.285511581583222),
    const LatLng(30.033366647389016, 31.26689507392588),
    const LatLng(29.99217555011128, 31.282938583489916),
  ];

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
// calculate distance function
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
/*
  void setMarker(LatLng _location) {
    Marker newMarker = Marker(
        markerId: MarkerId(_location.latitude.toString()),
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
*/
  void setOriginPath() {
 

    allPolyLine.add(Polyline(
        polylineId: PolylineId(currentLocation.latitude.toString()),
        width: 5,
        visible: true,
        color: Colors.red,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: originPath));

    update();
  }

  void setCurrentPath() {
    Marker newMarker = Marker(
        markerId: MarkerId(currentLocation.latitude.toString()),
        icon: BitmapDescriptor.defaultMarker,
        // icon: _locationIcon,
        position: currentLocation,
        infoWindow: InfoWindow(
            title: "Info",
            snippet:
                "${currentLocation.latitude}, ${currentLocation.longitude}"),
        onTap: () {});

    currentMark = newMarker;
    carCurrentPath.add(currentMark.position);

    allPolyLine.add(Polyline(
        polylineId: PolylineId(currentLocation.latitude.toString()),
        width: 5,
        visible: true,
        color: Colors.green,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: carCurrentPath));
    update();
  }

  void onCamMove(LatLng newPos) {
    currentLocation = newPos;
    update();
  }
}




/*
//<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//






  void setMarkers(List<LatLng> locations) {
    AllNearstPointsController nearstPoint = Get.put(AllNearstPointsController(
        deviceCurrentLocation.currentLat ?? 0.0,
        deviceCurrentLocation.currentLong ?? 0.0));

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
                title: "معلومات عن البؤرة ",
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText:
                    "انت على بعد مسافة ${calculateDistance(deviceCurrentLocation.currentLat, deviceCurrentLocation.currentLong, double.parse(nearstPoint.point[i].lat), double.parse(nearstPoint.point[i].long))} متر من البؤرة ",
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitEpicenterScreen());
                  },
                  child: Container(
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
                ),
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
                        " الذهاب إلى الموقع  ",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      )),
                ),
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitEpicenterScreen());
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "إضافة زيارة للبؤرة ",
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


 */