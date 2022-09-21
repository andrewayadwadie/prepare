import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../core/service/solved_epicenter_services.dart';
import '../../../../utils/style.dart';
import '../../../utils/constants.dart';
import 'daily_work_audio_controller.dart';
import 'daily_work_map_proprities_controller.dart';

class DailyWorkMapCtrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    insertDataToList();
  }
 @override
  void onClose() {
     prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {}).cancel();
    super.onClose();
  }

  bool isDataDidnotSend = false;
  void changeisDataDidnotSend() {
    isDataDidnotSend = !isDataDidnotSend;
    update();
  }

  DailyWorkMapPropertiesController prop =
      Get.put(DailyWorkMapPropertiesController());
  DailyWorkAudioController audio = Get.put(DailyWorkAudioController());

  //! go to this location
  Future<void> animateCamera(LocationData _location) async {
    GoogleMapController controller = await prop.compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        bearing: 0.0,
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 15.5);

    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPostion));
  }

  Future<void> animateCameraToFinishTask(LocationData _location) async {
    GoogleMapController controller = await prop.compeleteController.future;
    CameraPosition _cameraPostion = CameraPosition(
        bearing: 0.0,
        target: LatLng(
          _location.latitude!,
          _location.longitude!,
        ),
        zoom: 30.0);

    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPostion));
  }

//! fetch data from line that came from excel in two lists test line and voices
  void insertDataToList() {
    for (var item in prop.redRoutePointTest) {
      prop.testLineCordinatesFromExcel.add(LatLng(item['lat'], item['long']));
      //   prop.voices.add(item['disc']);
    }
  }

//!calculate distance function
  double calculateDistance(double lat1, double long1, double lat2, double long2) {
    var d1 = lat1 * (math.pi / 180.0);
    var num1 = long1 * (math.pi / 180.0);
    var d2 = lat2 * (math.pi / 180.0);
    var num2 = long2 * (math.pi / 180.0) - num1;
    var d3 = math.pow(math.sin((d2 - d1) / 2.0), 2.0) +
        math.cos(d1) * math.cos(d2) * math.pow(math.sin(num2 / 2.0), 2.0);
    return 6376500.0 * (2.0 * math.atan2(math.sqrt(d3), math.sqrt(1.0 - d3)));
  }

//! if epicenter problem is solved
  void isTaskDone() {
    prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
      //! loop in all marks of Epicenter and check if it is in range of epicenter or not
      for (var epicenterPoint in prop.epicenterPointsList) {
        if (calculateDistance(
                event.latitude ?? 0.0,
                event.longitude ?? 0.0,
                double.parse(epicenterPoint.lat),
                double.parse(epicenterPoint.long)) <
            50.0) {
          Get.snackbar('The problem has been resolved'.tr,
              "The Epicenter problem has been resolved",
              backgroundColor: Colors.white);
          //! remove mark from List of markers
          prop.allMarkers.removeWhere((maker) =>
              maker.position ==
              LatLng(double.parse(epicenterPoint.lat),
                  double.parse(epicenterPoint.long)));
          SolvedEpicenterService.addSolvedEpicenterService(
            id: epicenterPoint.id,
            type: epicenterPoint.type,
          ).then((res) {
            if (res == 200) {
              dev.log("epicenter solved and sended successfully to server");
            }
          });
          prop.epicenterPointsList.remove(epicenterPoint);

          update();
        }
      }
      //! loop in all marks of Discover and check if it is in range of Discover or not
      for (var discoverPoint in prop.discoverPointsList) {
        if (calculateDistance(
                event.latitude ?? 0.0,
                event.longitude ?? 0.0,
                double.parse(discoverPoint.lat),
                double.parse(discoverPoint.long)) <
            60.0) {
          Get.snackbar('The problem has been resolved'.tr,
              "The Discover problem has been resolved",
              backgroundColor: Colors.white);
          //! remove mark from List of markers

          prop.allMarkers.removeWhere((maker) =>
              maker.position ==
              LatLng(double.parse(discoverPoint.lat),
                  double.parse(discoverPoint.long)));

          SolvedEpicenterService.addSolvedEpicenterService(
            id: discoverPoint.id,
            type: discoverPoint.type,
          ).then((res) {
            if (res == 200) {
              dev.log("discoverPoint solved and sended successfully to server");
            }
          });
          prop.discoverPointsList.remove(discoverPoint);
          update();
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
        points: pathDataFromApi));
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
      apiKey2,
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
      dev.log("can't find path");
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
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/metrize.png',
    );

    if (prop.allMarkers.isNotEmpty) {
      prop.allMarkers.remove(prop.allMarkers.last);
    }
    prop.allMarkers.add(Marker(
      markerId: MarkerId("$lat$long"),
      icon: markerbitmap,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Info", snippet: "$lat , $long"),
    ));
  }

  void startMission(BuildContext context) async {
    //?<<<<<<<<<<<<< check if car in Start or not >>>>>>>>>>>>
    //?<<<<<<<<<<<< if true draw google direction to Start point >>>>>>>>>>>>>>>>
    dev.log("deviceCurrentLocation.lat ${prop.deviceCurrentLocation.lat}");
    dev.log("deviceCurrentLocation.long ${prop.deviceCurrentLocation.long}");
    dev.log("first point of path from api .lat ${allPathDataFromApi[0]["lat"]}");
    dev.log("first point of path from api.long ${allPathDataFromApi[0]["long"]}");
    //! if user far from start location and draw google direction to Start point
    if (calculateDistance(
            allPathDataFromApi[0]["lat"],
            allPathDataFromApi[0]["long"],
            prop.deviceCurrentLocation.lat ?? 0.0,
            prop.deviceCurrentLocation.long ?? 0.0) >
        300.0) {
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
                pathDataFromApi[0].latitude,
                pathDataFromApi[0].longitude,
              )
            ]);
            Get.back();
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
  //    animateCamera(await prop.deviceCurrentLocation.location.getLocation());
      update();
      prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
        setMark(event.latitude ?? 0.0, event.longitude ?? 0.0);
        animateCamera(event);
        //!voice algorithm
        for (var i = 0; i < allPathDataFromApi.length; i++) {
          if (calculateDistance(
                      event.latitude ?? 0.0,
                      event.longitude ?? 0.0,
                      allPathDataFromApi[i]['lat'],
                      allPathDataFromApi[i]['long']) <=
                  5.0 ||
              calculateDistance(
                      event.latitude ?? 0.0,
                      event.longitude ?? 0.0,
                      allPathDataFromApi[i]['lat'],
                      allPathDataFromApi[i]['long']) ==
                  0.0) {
            if (allPathDataFromApi[i]['description'] == "s") {
              dev.log("voice is : Start");
              audio.playerAudioStart();
            }
            if (allPathDataFromApi[i]['description'] == "r") {
              dev.log("voice is : right");
              audio.playerAudioUturnRight();
            }
            if (allPathDataFromApi[i]['description'] == "l") {
              dev.log("voice is : left");
              audio.playerAudioUturnLeft();
            }
            if (allPathDataFromApi[i]['description'] == "u") {
              dev.log("voice is : uturn right");
              audio.playerAudioUTurn();
            }

            if (allPathDataFromApi[i]['description'] == "u b") {
              dev.log("voice is : uturn back");
              audio.playerAudioTurnBack();
            }
            if (allPathDataFromApi[i]['description'] == "e") {
              dev.log("voice is : end");
              audio.playerAudioFinish();
            }
            if (allPathDataFromApi[i]['description'] == "c") {
              dev.log("voice is : go straight ahead ");
              audio.playerAudioStraight();
            }
          }
        }
        isTaskDone();
        update();
      });
    }
  }

  //! get epicenter point from api and put it in list
  void addEpicenterPoints(List epicenterPointsList) async {
    //? epicenterPointsList it is list that come from api

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/flyepicenter.png',
    );
    for (var i = 0; i < epicenterPointsList.length; i++) {
      prop.allMarkers.add(Marker(
        markerId: MarkerId(
            "${epicenterPointsList[i].lat} $epicenterPointsList[i].long}"),
        icon: markerbitmap,
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
    //? discoverPointsList it is list that come from api

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/b1.png',
    );
    for (var i = 0; i < discoverPointsList.length; i++) {
      prop.allMarkers.add(Marker(
        markerId: MarkerId(
            "${discoverPointsList[i].lat} $discoverPointsList[i].long}"),
        icon: markerbitmap,
        position: LatLng(double.parse(discoverPointsList[i].lat),
            double.parse(discoverPointsList[i].long)),
        infoWindow: InfoWindow(
            title: 'Site Information'.tr,
            snippet: "type :${discoverPointsList[i].type}"),
      ));
      update();
    }
  }
/*
  //! play sound from List of points
  void playSound(List<Map<String, dynamic>> pointsList) {
    int temp = 0;
    for (var i = 0; i < pointsList.length; i++) {
      if (calculateDistance(pointsList[i]["lat"], pointsList[i]["long"],
              pointsList[i + 1]["lat"], pointsList[i + 1]["long"]) <=
          20.0) {
        temp++;
      } else {
        if (temp == 2) {
          audio.playerAudioTurnBack();
          dev.log("turn back voice plyed");
        }
        if (temp == 3) {
          audio.playerAudioUturnRight();
          dev.log("right voice plyed");
        }
        if (temp == 5) {
          audio.playerAudioUturnLeft();
          dev.log("left voice plyed");
        }
        if (temp == 7) {
          // audio.playerAudioTurnForward();
          dev.log("turn forward voice plyed");
        }
        //! that mean go Straight and reset temp to 0
        temp = 0;
      }
    }
  }

//! voice Algorithm
  void getVoicefromList(List<Map<String, dynamic>> routePointsList) {
    int tempIteriable = 0;
    List<Map<String, dynamic>> tempList = [];
    prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
      for (int i = 0; i < routePointsList.length; i++) {
        if (tempIteriable == 0 || tempIteriable % 9 == 0) {
          if (calculateDistance(event.latitude ?? 0.0, event.longitude ?? 0.0,
                  routePointsList[i]["lat"], routePointsList[i]["long"]) <=
              1.0) {
            tempList.clear();
            tempList.add(routePointsList[i + 1]);
            tempList.add(routePointsList[i + 2]);
            tempList.add(routePointsList[i + 3]);
            tempList.add(routePointsList[i + 4]);
            tempList.add(routePointsList[i + 5]);
            tempList.add(routePointsList[i + 6]);
            tempList.add(routePointsList[i + 7]);
            tempList.add(routePointsList[i + 8]);
            tempList.add(routePointsList[i + 9]);
            playSound(tempList);
            tempIteriable + 9;
          }
        }
      }
    });
  }

  //! test new voice algorithm

  void testNewVoiceAlgorithm() {
    prop.deviceCurrentLocation.location.onLocationChanged.listen((event) {
      if (calculateDistance(
              event.latitude ?? 0.0,
              event.longitude ?? 0.0,
              prop.redRoutePointTest[0]["lat"],
              prop.redRoutePointTest[0]["long"]) <=
          5) {
        for (int i = 0; i < prop.redRoutePointTest.length; i++) {
          for (var j = 0; j < prop.descriptionTest.length; j++) {
            if (calculateDistance(
                    prop.redRoutePointTest[i]["lat"],
                    prop.redRoutePointTest[i]["long"],
                    prop.redRoutePointTest[i + 1]["lat"],
                    prop.redRoutePointTest[i + 1]["long"]) ==
                prop.descriptionTest[j]["distance"]) {
              dev.log(" voice is : ${prop.descriptionTest[j]['discreption']}");
            }
          }
        }
      }
    });
  }
*/
//!=================================================================
//!=================================================================
  List<Map<String, dynamic>> allPathDataFromApi = [];
  List<LatLng> pathDataFromApi = [];
//! convert data frpm Api to object
  void convertDataFromApi(List dataFromApi) {
    dev.log(
        "lat from api : ${dataFromApi[0]['lat']} and type ${dataFromApi[0]['lat'].runtimeType}");
    dev.log(
        "long from api : ${dataFromApi[0]['long']} and type ${dataFromApi[0]['long'].runtimeType}  ");
    dev.log(
        "description from api : ${dataFromApi[0]['description']} and type ${dataFromApi[0]['description'].runtimeType}");
    for (var element in dataFromApi) {
      allPathDataFromApi.add({
        "lat": element['lat'],
        "long": element['long'],
        "description": element['description']
      });
      pathDataFromApi.add(LatLng(element['lat'], element['long']));
    }
  }
}
