import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import '../../../view/epicenter/visit_epicenter/visit_epicenter_screen.dart';
import '../current_location_controller.dart';
import '../epicenter/all_nearst_point_controllerd.dart';

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

  double calculateDistance(lat1, long1, lat2, long2) { 
    var d1 = lat1 * (math.pi / 180.0);
    var num1 = long1 * (math.pi / 180.0);
    var d2 = lat2 * (math.pi / 180.0);
    var num2 = long2 * (math.pi / 180.0) - num1;
    var d3 = math.pow(math.sin((d2 - d1) / 2.0), 2.0) +
        math.cos(d1) * math.cos(d2) * math.pow(math.sin(num2 / 2.0), 2.0);
    return 6376500.0 * (2.0 * math.atan2(math.sqrt(d3), math.sqrt(1.0 - d3)));
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
        deviceCurrentLocation.lat ?? 0.0,
        deviceCurrentLocation.long ?? 0.0));

    for (var i = 0; i < locations.length; i++) {
      marks.add(Marker(
          markerId: MarkerId(locations[i].toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(10),
          position: locations[i],
          onTap: () {
            if (calculateDistance(
                    deviceCurrentLocation.lat,
                    deviceCurrentLocation.long,
                    double.parse(nearstPoint.point[i].lat),
                    double.parse(nearstPoint.point[i].long)) <
                200.0) {
              Get.defaultDialog(
                title: 'Information about insect density measurement site'.tr,
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText:
                    "${'You are within distance'.tr} ${(calculateDistance(deviceCurrentLocation.lat, deviceCurrentLocation.long, double.parse(nearstPoint.point[i].lat), double.parse(nearstPoint.point[i].long))).toStringAsFixed(3)} ${'meter'.tr} ",
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitEpicenterScreen(
                      id: nearstPoint.point[i].id,
                    ));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 135,
                      height: 40,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child:  Text(
                        'Add a visit'.tr,
                        style:const TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              );
            } else {
              Get.defaultDialog(
                title: 'Information about insect density measurement site'.tr,
                titleStyle: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
                middleText: """
  ${'Location'.tr} : ${nearstPoint.point[i].name}
  ${'Type of insect'.tr}:  ${nearstPoint.point[i].insectName}
  ${'Date'.tr} : ${DateFormat('yyyy-MM-dd : kk:mm').format(DateTime.parse(nearstPoint.point[i].date))}
  ${'District'.tr} :  ${nearstPoint.point[i].districtName}
  ${'Baladya'.tr} :  ${nearstPoint.point[i].cityName}
  ${'notes'.tr} :  ${nearstPoint.point[i].recommendation}
 
                           """,
                           
                confirm: InkWell(
                  onTap: () {
                    Get.back();
                    setPolyLine([
                      LatLng(double.parse(nearstPoint.point[i].lat),
                          double.parse(nearstPoint.point[i].long)),
                      LatLng(
                        deviceCurrentLocation.lat??0.0,
                        deviceCurrentLocation.long??0.0,
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
                      child:  Text(
                        'Go to the site'.tr,
                        style:const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      )),
                ),
                cancel: InkWell(
                  onTap: () {
                    Get.to(VisitEpicenterScreen(id: nearstPoint.point[i].id));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                          color: lightPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child:  Text(
                        'Add a visit'.tr,
                        style:const TextStyle(
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
      apiKey2,
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
    if (result.status == "ZERO_RESULTS") {
      Get.snackbar('There is a problem'.tr, 'There is no way suitable for this site'.tr);
    }
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      Get.snackbar('There is a problem'.tr, 'There is a problem in locating'.tr);

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
