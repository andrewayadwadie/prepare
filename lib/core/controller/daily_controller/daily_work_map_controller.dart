import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
//import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_audio_controller.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_point_controller.dart';
import 'package:prepare/utils/style.dart';

import '../current_location_controller.dart';

class DailyWorkMapCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    insertDataToList();
  }

  CurrentLocationController deviceCurrentLocation =
      Get.put(CurrentLocationController());

  DailyWorkAudioController audio = Get.put(DailyWorkAudioController());

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
  bool testButtom = true;
  List<Map<String, dynamic>> magdyPoints = [
    {
      "lat": 30.08621996021523,
      "long": 31.341046513569676,
      "disc": "start mission"
    },
    {"lat": 30.087396, "long": 31.341235, "disc": "straight"},
    {"lat": 30.087948, "long": 31.341331, "disc": "straight"},
    {"lat": 30.088524, "long": 31.341417, "disc": "straight"},
    {"lat": 30.089429, "long": 31.341535, "disc": "straight"},
    {"lat": 30.089884, "long": 31.341605, "disc": "straight"},
    {"lat": 30.090338, "long": 31.341701, "disc": "right"},
    {"lat": 30.090431, "long": 31.341782, "disc": "right"},
    {"lat": 30.090427, "long": 31.341878, "disc": "right"},
    {"lat": 30.090385, "long": 31.341948, "disc": "straight"},
    {"lat": 30.089703, "long": 31.342854, "disc": "straight"},
    {"lat": 30.088970, "long": 31.343836, "disc": "right"},
    {"lat": 30.088826, "long": 31.343906, "disc": "right "},
    {"lat": 30.088584, "long": 31.343707, "disc": "straight"},
    {"lat": 30.088343, "long": 31.343579, "disc": "right "},
    {"lat": 30.088450, "long": 31.343316, "disc": "straight"},
    {"lat": 30.089414, "long": 31.342037, "disc": "straight"},
    {"lat": 30.089718, "long": 31.341641, "disc": "distenation"},
  ];

  List<LatLng> test3 = [];
  List<String> voices = [];
  void insertDataToList() {
    for (var item in magdyPoints) {
      test3.add(LatLng(item['lat'], item['long']));
      voices.add(item['disc']);
    }
  }

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
    const LatLng(30.088524, 31.341417),
    const LatLng(30.090338, 31.341701),
    const LatLng(30.090385, 31.341948),
    const LatLng(30.088970, 31.343836),
    const LatLng(30.088343, 31.343579),
    const LatLng(30.089414, 31.342037),
    const LatLng(30.086264419385355, 31.341032372089625)
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
        bearing: 0.0,
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 19.0);

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
    deviceCurrentLocation.location.onLocationChanged.listen((event) {
      for (var i = 0; i < positionOfMarkers.length; i++) {
        if (calculateDistance(event.latitude, event.longitude,
                positionOfMarkers[i].latitude, positionOfMarkers[i].longitude) <
            50.0) {
          for (var element in allMarkers) {
            if (element.markerId.value == i.toString()) {
              Get.snackbar("ملحوظة ", "تم حل المشكلة الموجودة فى الموقع رقم $i",
                  backgroundColor: Colors.white);
            }
          }

          allMarkers
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
    allMarkers.add(Marker(
      markerId: const MarkerId("test mark"),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      // icon: _locationIcon,
      position: positionOfMarkers[0],
    ));
    update();

    allPolyLine.add(Polyline(
        polylineId: PolylineId(
            "${deviceCurrentLocation.lat}${deviceCurrentLocation.long}"),
        width: 6,
        visible: true,
        color: Colors.red,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: test3));
    update();
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

  void setGooglePolyLine(List<LatLng> locations) async {
    // List of coordinates to join
    // Initializing PolylinePoints
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
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      dev.log("result failed ");
    }

    allPolyLine.add(Polyline(
        polylineId: PolylineId(locations[0].latitude.toString()),
        width: 6,
        visible: true,
        color: Colors.yellow,
        consumeTapEvents: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: polylineCoordinates));
    update();
  }

  void setMark(double lat, double long) async {
    final Uint8List currentIcon =
        await getBytesFromAsset('assets/images/circle.png', 120);
    allMarkers.remove(allMarkers.last);
    allMarkers.add(Marker(
      markerId: MarkerId("$lat$long"),
      icon: BitmapDescriptor.fromBytes(currentIcon),

      // icon: _locationIcon,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Info", snippet: "$lat , $long"),
    ));
  }

  void startMission(BuildContext context) async {
    //<<<<<<<<<<<<< check if car in Start or not >>>>>>>>>>>>
    //<<<<<<<<<<<< if true draw google direction to Start point >>>>>>>>>>>>>>>>
    if (calculateDistance(test3[0].latitude, test3[0].longitude,
            deviceCurrentLocation.lat, deviceCurrentLocation.long) >
        5000.0) {
      Get.defaultDialog(
        title: "ملحوظة",
        content: const Text(
          "لا يمكن بدء المهمة لانك بعيد عن المسار ",
        ),
        confirm: InkWell(
          onTap: () {
            setGooglePolyLine([
              LatLng(deviceCurrentLocation.lat ?? 0.0,
                  deviceCurrentLocation.long ?? 0.0),
              LatLng(
                test3[0].latitude,
                test3[0].longitude,
              )
            ]);
            Get.back();
            deviceCurrentLocation.location.onLocationChanged.listen((event) {
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
              child: const Text(
                "إذهب الى بداية المسار",
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
        ),
      );
      //<<<<<<<<<<<< if false start Gis Directions with voices >>>>>>>>>>>>>>>>
    } else {
      testButtom = false;
      await animateCamera(await deviceCurrentLocation.location.getLocation());
      deviceCurrentLocation.location.onLocationChanged.listen((event) {
        setMark(event.latitude ?? 0.0, event.longitude ?? 0.0);
        animateCamera(event);
        for (var i = 0; i < test3.length; i++) {
          if ((event.speed ?? 0.0) > 10.0) {
            audio.playerAudioSlowSpeed();
            dev.log("slow speed");
          } else if (calculateDistance(test3[i].latitude, test3[i].longitude,
                  event.latitude, event.longitude) <=
              20.0) {
            if (voices[i] == "start mission") {
              dev.log("start mission");
              audio.playAudioStart();
            } else if (voices[i] == "straight") {
              dev.log("straight");
              audio.playAudioStraight();
            } else if (voices[i] == "right") {
              dev.log("right");
              audio.playerAudioRight();
            }
            //  else if (voices[i] == "distenation") {
            //   await audio.playerAudioStopHere();
            //   break;
            // }
          }
        }
      });
    }
  }
}
