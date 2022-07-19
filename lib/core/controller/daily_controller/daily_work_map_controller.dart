import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:prepare/utils/style.dart';

import 'daily_work_map_proprities_controller.dart';

class DailyWorkMapCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    insertDataToList();
  }

  DailyWorkMapPropertiesController prop =
      Get.put(DailyWorkMapPropertiesController());

  //! go to this location
  Future<void> animateCamera(LocationData _location) async {
    final GoogleMapController controller =
        await prop.compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        bearing: 0.0,
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 19.0);

    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPostion));
  }

//! fetch data from line that came from excel in two lists test line and voices
  void insertDataToList() {
    for (var item in prop.redRoutePoint) {
      prop.testLineCordinatesFromExcel.add(LatLng(item['lat'], item['long']));
      //   prop.voices.add(item['disc']);
    }
  }

//!calculate distance function
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

//! if epicenter problem is solved
  void isTaskDone() {
    prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
      for (var i = 0; i < prop.dummyEpicenterPoint.length; i++) {
        if (calculateDistance(
                event.latitude,
                event.longitude,
                prop.dummyEpicenterPoint[i].latitude,
                prop.dummyEpicenterPoint[i].longitude) <
            20.0) {
          for (var element in prop.allMarkers) {
            if (element.markerId.value == i.toString()) {
              Get.snackbar('The problem has been resolved'.tr,
                  "${'The problem is resolved at the site number'.tr} $i",
                  backgroundColor: Colors.white);
            }
          }

          prop.allMarkers
              .removeWhere((element) => element.markerId.value == i.toString());
          update();
        } else {
          continue;
        }
      }
    });
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

//!on map create it will draw red path and all point of problems
  void setCurrentPath() async {
    //! make list of point that coming from Api
    for (var item in prop.dailyWorkPoint.points) {
      prop.epicenterFromApi
          .add(LatLng(double.parse(item.lat), double.parse(item.long)));
    }

//! red path that coming from Excel
    prop.allPolyLine.add(Polyline(
        polylineId: PolylineId(
            "${prop.deviceCurrentLocation.lat}${prop.deviceCurrentLocation.long}"),
        width: 3,
        visible: true,
        color: Colors.red,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: prop.testLineCordinatesFromExcel));
    update();
  }

  void setnewPath(LatLng oldPoint, LatLng newPoint) async {
    prop.allPolyLine.add(Polyline(
        polylineId: PolylineId(
            "${oldPoint.latitude}${oldPoint.longitude}${newPoint.latitude}${newPoint.longitude}"),
        width: 6,
        visible: true,
        color: Colors.green,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: [oldPoint, newPoint]));

    prop.newPath.add(oldPoint);
    prop.newPath.add(newPoint);
    update();
  }

//! draw google line with prediction to driver to start from start point of real route (red route )
  void setGooglePolyLine(List<LatLng> locations) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4",
      PointLatLng(
          locations[0].latitude, locations[0].longitude), // Google Maps API Key
      PointLatLng(locations[1].latitude, locations[1].longitude),

      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        prop.polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      dev.log("result failed ");
    }

    prop.allPolyLine.add(Polyline(
        polylineId: PolylineId(locations[0].latitude.toString()),
        width: 6,
        visible: true,
        color: Colors.yellow,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: prop.polylineCoordinates));
    update();
  }

//!set current location of the driver markder
  void setMark(double lat, double long) async {
    final Uint8List currentIcon =
        await getBytesFromAsset('assets/images/circle.png', 120);
    prop.allMarkers.remove(prop.allMarkers.last);
    prop.allMarkers.add(Marker(
      markerId: MarkerId("$lat$long"),
      icon: BitmapDescriptor.fromBytes(currentIcon),
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Info", snippet: "$lat , $long"),
    ));
  }

  void startMission(BuildContext context) async {
    //?<<<<<<<<<<<<< check if car in Start or not >>>>>>>>>>>>
    //?<<<<<<<<<<<< if true draw google direction to Start point >>>>>>>>>>>>>>>>

    //! if user far from start location and draw google direction to Start point
    if (calculateDistance(
            prop.testLineCordinatesFromExcel[0].latitude,
            prop.testLineCordinatesFromExcel[0].longitude,
            prop.deviceCurrentLocation.lat,
            prop.deviceCurrentLocation.long) >
        5000.0) {
      Get.defaultDialog(
        title: 'There is a problem'.tr,
        content: Text(
          'The task can not be started because you are far from the path'.tr,
        ),
        confirm: InkWell(
          onTap: () {
            setGooglePolyLine([
              LatLng(prop.deviceCurrentLocation.lat ?? 0.0,
                  prop.deviceCurrentLocation.long ?? 0.0),
              LatLng(
                prop.testLineCordinatesFromExcel[0].latitude,
                prop.testLineCordinatesFromExcel[0].longitude,
              )
            ]);
            Get.back();
            prop.deviceCurrentLocation.location.onLocationChanged
                .listen((event) {
              setMark(event.latitude ?? 0.0, event.longitude ?? 0.0);
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: lightPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 20,
              child: Text(
                'Go to the beginning of the track'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )),
        ),
      );
      //?<<<<<<<<<<<< if false start Gis Directions with voices >>>>>>>>>>>>>>>>
    } else {
      prop.startMissionButton = false;
      animateCamera(await prop.deviceCurrentLocation.location.getLocation());
      update();
      prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
        setMark(event.latitude ?? 0.0, event.longitude ?? 0.0);
        animateCamera(event);
        update();
        for (var i = 0; i < prop.testLineCordinatesFromExcel.length; i++) {
          if ((event.speed ?? 0.0) > 10.0) {
            prop.audio.playerAudioSlowSpeed();
            dev.log("slow speed");
          } else if (calculateDistance(
                  prop.testLineCordinatesFromExcel[i].latitude,
                  prop.testLineCordinatesFromExcel[i].longitude,
                  event.latitude,
                  event.longitude) <=
              20.0) {
            if (prop.voices[i] == "start mission") {
              dev.log("start mission");
              prop.audio.playAudioStart();
            } else if (prop.voices[i] == "straight") {
              dev.log("straight");
              prop.audio.playAudioStraight();
            } else if (prop.voices[i] == "right") {
              dev.log("right");
              prop.audio.playerAudioRight();
            } else if (prop.voices[i] == "before right") {
              dev.log("before right");
              prop.audio.playerAudioBeforeRight();
            }
          }
        }
      });
    }
  }

  //! get epicenter point from api and put it in list
  void addEpicenterPoints(List epicenterPointsList) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/flyepicenter.png', 100);
    for (var i = 0; i < epicenterPointsList.length; i++) {
      prop.allMarkers.add(Marker(
        markerId: MarkerId(
            "${epicenterPointsList[i].lat} $epicenterPointsList[i].long}"),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(double.parse(epicenterPointsList[i].lat),
            double.parse(epicenterPointsList[i].long)),
        infoWindow: InfoWindow(
            title: 'Site Information'.tr,
            snippet: "type :${epicenterPointsList[i].type}"),
      ));
      update();
    }
  }

  //! get Discover point from api and put it in list
  void addDiscoverPoints(List discoverPointsList) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/b1.png', 100);
    for (var i = 0; i < discoverPointsList.length; i++) {
      prop.allMarkers.add(Marker(
        markerId: MarkerId(
            "${discoverPointsList[i].lat} $discoverPointsList[i].long}"),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(double.parse(discoverPointsList[i].lat),
            double.parse(discoverPointsList[i].long)),
        infoWindow: InfoWindow(
            title: 'Site Information'.tr,
            snippet: "type :${discoverPointsList[i].type}"),
      ));
      update();
    }
  }

  void playSound(List pointsList) {}
//! voice Algorithm
  void getVoicefromList(List routePointsList) {
    int tempIteriable = 0;
    List tempList = [];

    prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
      for (var i in routePointsList) {
        if (tempIteriable == 0 || tempIteriable % 9 == 0) {
          if (calculateDistance(event.latitude, event.longitude,
                  double.parse(i.lat), double.parse(i.long)) <=
              3.0) {
            tempList.clear();
            tempList.add(i + 1);
            tempList.add(i + 2);
            tempList.add(i + 3);
            tempList.add(i + 4);
            tempList.add(i + 5);
            tempList.add(i + 6);
            tempList.add(i + 7);
            tempList.add(i + 8);
            tempList.add(i + 9);
            playSound(tempList);
            tempIteriable + 9;
          }
        }
      }
    });
  }
}
