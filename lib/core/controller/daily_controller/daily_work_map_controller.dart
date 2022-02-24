import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_point_controller.dart';

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
  DailyWorkPointController dailyWorkPoint = Get.put(DailyWorkPointController());

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
  Set<Polyline> googlePolyline = {};
  Set<Marker> allMarkers = {};
  List<LatLng> carCurrentPath = [];
  List<LatLng> apiPoint = [];
  ///////////////////////////////
  List<LatLng> test = const [
    LatLng(
      30.08560262076806,
      31.340979738974635,
    ),
    LatLng(
      30.084521095636315,
      31.34061495633153,
    ),
    LatLng(
      30.083801620013194,
      31.34072760731564,
    ),
    LatLng(
      30.08347205193825,
      31.34139279645936,
    ),
    LatLng(
      30.083267811489915,
      31.34191314190976,
    ),
    LatLng(
      30.08342098806933,
      31.342315472797715,
    ),
    LatLng(
      30.084813490925345,
      31.34543225008741,
    ),
    LatLng(30.084901674688442, 31.345426856307533),
    LatLng(
      30.086368491073465,
      31.34453102812847,
    ),
    LatLng(
      30.086182823891193,
      31.34384970777755,
    ),
    LatLng(30.085537635279746, 31.342492502237675),
    LatLng(
      30.08550514342343,
      31.34233157011478,
    ),
    LatLng(30.086544884610458, 31.342519325832253),
    LatLng(30.086544884610458, 31.342519325832253),
    LatLng(30.086735194170917, 31.341982878915207),
    LatLng(
      30.08675839893869,
      31.341237216370995,
    ),
    LatLng(30.086637713450653, 31.341097750269967),
    LatLng(30.086219961655274, 31.34103338063571),
  ];
  List<LatLng> test2 = [
    const LatLng(
      30.086763039458297,
      31.34257833719442,
    ),
    const LatLng(
      30.086753757295465,
      31.3422564701627,
    ),
    const LatLng(
      30.086739832567737,
      31.341682474306445,
    ),
    const LatLng(
      30.08676303975746,
      31.34126941167389,
    ),
    const LatLng(
      30.086744472249443,
      31.341113842740604,
    ),
    const LatLng(
      30.08664699687594,
      31.341108479104008,
    ),
    const LatLng(30.086238528416267, 31.34103874491316),
  ];
  List<LatLng> positionOfMarkers = [
    const LatLng(
      30.08578961496697,
      31.340995544345827,
    ),
    const LatLng(
      30.084489871229206,
      31.340843831398807,
    ),
    const LatLng(
      30.08371185116205,
      31.340774089920778,
    ),
    const LatLng(
      30.084164628308102,
      31.343895635323648,
    ),
    const LatLng(
      30.08468764451231,
      31.345095556666184,
    ),
    const LatLng(
      30.086108449504934,
      31.34373327100525,
    ),
    const LatLng(
      30.085819614967953,
      31.342398012844708,
    ),
    const LatLng(
      30.08677200777047,
      31.34136949633439,
    ),
  ];
  List<LatLng> newPath = [];
  ////////////////////////////////
  List<LatLng> polylineCoordinates = [];
  var polyKey = Random().nextDouble();

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

 void isTaskDone() {
    for (var i = 0; i < positionOfMarkers.length; i++) {
      if (calculateDistance(
              deviceCurrentLocation.lat,
              deviceCurrentLocation.long,
              positionOfMarkers[i].latitude,
              positionOfMarkers[i].longitude) <
          100.0) {
        Get.snackbar("ملحوظة ", "تم حل المشكلة الموجودة فى الموقع رقم $i");
        allMarkers
            .removeWhere((element) => element.markerId.value == i.toString());
        update();
      } else {
        continue;
      }
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setCurrentPath() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/b1.png', 100);

    for (var item in dailyWorkPoint.points) {
      apiPoint.add(LatLng(double.parse(item.lat), double.parse(item.long)));
    }

    for (var i = 0; i < positionOfMarkers.length; i++) {
      allMarkers.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          // icon: _locationIcon,
          position: positionOfMarkers[i],
          infoWindow:
              InfoWindow(title: "معلومات عن الموقع ", snippet: " موقع رقم $i"),
          onTap: () {}));
      update();
    }
    // Marker newMarker = Marker(
    //     markerId: MarkerId(currentLocation.latitude.toString()),
    //     icon: BitmapDescriptor.defaultMarker,
    //     // icon: _locationIcon,
    //     position: currentLocation,
    //     infoWindow: InfoWindow(
    //         title: "Info",
    //         snippet:
    //             "${currentLocation.latitude}, ${currentLocation.longitude}"),
    //     onTap: () {});

    // allMarkers.add(newMarker);
    //  carCurrentPath.add(currentMark.position);

    allPolyLine.add(Polyline(
        polylineId: PolylineId(currentLocation.latitude.toString()),
        width: 6,
        visible: true,
        color: Colors.red,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: test));
    update();
    // allPolyLine.add(Polyline(
    //     polylineId: PolylineId(currentLocation.longitude.toString()),
    //     width: 6,
    //     visible: true,
    //     color: Colors.green,
    //     consumeTapEvents: true,
    //     startCap: Cap.roundCap,
    //     endCap: Cap.roundCap,
    //     points: test2));
    // update();
  }

  void setnewPath(LatLng oldPoint, LatLng newPoint) async {
    allPolyLine.add(Polyline(
        polylineId: PolylineId(
            "${oldPoint.latitude}${oldPoint.longitude}${newPoint.latitude}${newPoint.longitude}"),
        width: 6,
        visible: true,
        color: Colors.green,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: [oldPoint, newPoint]));

    update();
    newPath.add(oldPoint);
    newPath.add(newPoint);
    update();
  }

  void setGooglePolyLine() async {
    for (var item in dailyWorkPoint.points) {
      apiPoint.add(LatLng(double.parse(item.lat), double.parse(item.long)));
    }
    // List of coordinates to join
    // Initializing PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4",
      // Google Maps API Key
      //origin
      PointLatLng(
        deviceCurrentLocation.currentLat,
        deviceCurrentLocation.currentLong,
      ),
      //destination
      PointLatLng(apiPoint.last.latitude, apiPoint.last.longitude),
      //travelMOde
      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      dev.log("failed");
    }

    allPolyLine.add(Polyline(
        polylineId: PolylineId(currentLocation.longitude.toString()),
        width: 5,
        visible: true,
        color: Colors.green,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: polylineCoordinates));
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