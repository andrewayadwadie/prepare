import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_map_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/daily_work/service/dailty_work_service.dart';
import 'package:prepare/view/mapbox/controller/mapbox_controller.dart';

// ignore: must_be_immutable
class DailyWorkScreen extends StatelessWidget {
  DailyWorkScreen({Key? key}) : super(key: key);

  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());

  MapBoxNavigationViewController? mapBoxController;

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final diffrence = DateTime.now().difference(timeBackPressed);
          final isExitWarning = diffrence >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            const message = "إضغط مرة أخري للرجوع";
            Get.snackbar("خروج من الخريطة", message,
                snackPosition: SnackPosition.BOTTOM,
                animationDuration: const Duration(milliseconds: 500));

            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: SafeArea(
            child: GetBuilder<DailyWorkMapCtrl>(
                init: DailyWorkMapCtrl(),
                builder: (mapCtrl) {
                  return GetBuilder<InternetController>(
                      init: InternetController(),
                      builder: (net) {
                        return GetBuilder<MapBoxController>(
                            init: MapBoxController(),
                            builder: (box) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  GoogleMap(
                                    initialCameraPosition:
                                        mapCtrl.initialCamPos,
                                    mapType: MapType.normal,
                                    // onTap: (LatLng newPosition)=> mapCtrl.setGooglePolyLine(),
                                    markers: mapCtrl.allMarkers,
                                    polylines: mapCtrl.allPolyLine,
                                    myLocationEnabled: true,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      mapCtrl.compeleteController
                                          .complete(controller);
                                      //mapCtrl.setGooglePolyLine();
                                      Future.delayed(const Duration(seconds: 2))
                                          .then((value) =>
                                              mapCtrl.setCurrentPath());
                                      ///////////////////////////////////////////////////////
                                      currentLocation.location.onLocationChanged
                                          .listen((event) {
                                        currentLocation.location
                                            .getLocation()
                                            .then((curent) {
                                          if (mapCtrl.calculateDistance(
                                                  curent.latitude,
                                                  curent.longitude,
                                                  event.latitude,
                                                  event.longitude) >
                                              5.0) {
                                            mapCtrl.isTaskDone();
                                            log(" speed = ${event.speed}");
                                            log("Date = ${DateTime.now()}");
                                            log("current = ${curent.latitude},${curent.longitude}");
                                            log("event = ${event.latitude},${event.longitude}");
                                            log("distance = ${mapCtrl.calculateDistance(curent.latitude, curent.longitude, event.latitude, event.longitude)}");
                                            mapCtrl.setnewPath(
                                                LatLng(
                                                  curent.latitude ?? 0.0,
                                                  curent.longitude ?? 0.0,
                                                ),
                                                LatLng(event.latitude ?? 0.0,
                                                    event.longitude ?? 0.0));
                                            net.checkInternet().then((val) {
                                              if (val) {
                                                DailyWorkService.addLine(
                                                        date: DateTime.now()
                                                            .toString(),
                                                        lat: event.latitude
                                                            .toString(),
                                                        long: curent.longitude
                                                            .toString(),
                                                        speed: event.speed
                                                            .toString())
                                                    .then((value) {
                                                  if (value == 401) {
                                                    Get.offAll(
                                                        const LoginScreen());
                                                  } else if (value == 400) {
                                                    Get.snackbar("مشكلة",
                                                        "يوجد مشكلة فى ارسال البيانات ");
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
                                  //////////////////////////////////////////
                                    },
                                    onCameraMove: (CameraPosition newPos) {
                                      // mapCtrl.setCurrentPath();
                                      //mapCtrl.onCamMove(newPos.target);
                                      //mapCtrl.setCurrentPath();
                                      //mapCtrl.setOriginPath();
                                    },
                                  ),
                                  /*
                                  Positioned(
                                    bottom: MediaQuery.of(context).size.height /
                                        200,
                                    left:
                                        MediaQuery.of(context).size.width / 200,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          border: Border.all(
                                              width: 8, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: MapBoxNavigationView(
                                          options: MapBoxOptions(
                                              zoom: 15.0,
                                              tilt: 0.0,
                                              bearing: 0.0,
                                              enableRefresh: false,
                                              alternatives: true,
                                              voiceInstructionsEnabled: true,
                                              bannerInstructionsEnabled: true,
                                              allowsUTurnAtWayPoints: true,
                                              mode: MapBoxNavigationMode
                                                  .drivingWithTraffic,
                                              units: VoiceUnits.imperial,
                                              simulateRoute: false,
                                              animateBuildRoute: true,
                                              longPressDestinationEnabled: true,
                                              language: "en"),
                                          onRouteEvent:
                                              box.onEmbeddedRouteEvent,
                                          onCreated:
                                              (MapBoxNavigationViewController
                                                  controller) async {
                                                    controller.initialize();
                                            //      box.controller = controller;
                                            List<WayPoint> wayPoints = [];
                                            // wayPoints.add(origin);
                                            wayPoints.add(box.stop0);wayPoints.add(box.stop1);wayPoints.add(box.stop2);wayPoints.add(box.stop3);wayPoints.add(box.stop5);wayPoints.add(box.stop6);wayPoints.add(box.stop7);wayPoints.add(box.stop8);wayPoints.add(box.stop9);wayPoints.add(box.stop10);wayPoints.add(box.stop11);wayPoints.add(box.stop12);wayPoints.add(box.stop13);wayPoints.add(box.stop14);wayPoints.add(box.stop15);wayPoints.add(box.stop16);wayPoints.add(box.stop17);wayPoints.add(box.stop18);wayPoints.add(box.stop19);wayPoints.add(box.stop20);wayPoints.add(box.stop21);wayPoints.add(box.stop22);wayPoints.add(box.stop23);wayPoints.add(box.stop24);wayPoints.add(box.stop25);wayPoints.add(box.stop26);wayPoints.add(box.stop27);wayPoints.add(box.stop28);wayPoints.add(box.stop29);wayPoints.add(box.stop30);
                                            controller.buildRoute(
                                                wayPoints: wayPoints);
                                            
                                            controller.startNavigation(
                                              options: MapBoxOptions(
                                                  zoom: 15.0,
                                                  tilt: 0.0,
                                                  bearing: 0.0,
                                                  enableRefresh: false,
                                                  alternatives: true,
                                                  voiceInstructionsEnabled:
                                                      true,
                                                  bannerInstructionsEnabled:
                                                      true,
                                                  allowsUTurnAtWayPoints: true,
                                                  mode: MapBoxNavigationMode
                                                      .drivingWithTraffic,
                                                  units: VoiceUnits.imperial,
                                                  simulateRoute: false,
                                                  animateBuildRoute: true,
                                                  longPressDestinationEnabled:
                                                      true,
                                                  language: "en"),
                                            );
                                          }),
                                    ),
                                  ),
                                  */
                                ],
                              );
                            });
                      });
                })),
      ),

      
      floatingActionButton:  GetBuilder<MapBoxController>(
                init: MapBoxController(),
                builder: (box) {
                  return FloatingActionButton(
                    onPressed: () async {
                      var wayPoints = <WayPoint>[];
                      // wayPoints.add(origin);
                      wayPoints.add(box.stop0);
                      wayPoints.add(box.stop1);
                      wayPoints.add(box.stop2);
                      wayPoints.add(box.stop3);
                      wayPoints.add(box.stop5);
                      wayPoints.add(box.stop6);
                      wayPoints.add(box.stop7);
                      wayPoints.add(box.stop8);
                      wayPoints.add(box.stop9);
                      wayPoints.add(box.stop10);
                      wayPoints.add(box.stop11);
                      wayPoints.add(box.stop12);
                      wayPoints.add(box.stop13);
                      wayPoints.add(box.stop14);
                      wayPoints.add(box.stop15);
                      wayPoints.add(box.stop16);
                      wayPoints.add(box.stop17);
                      wayPoints.add(box.stop18);
                      wayPoints.add(box.stop19);
                      wayPoints.add(box.stop20);
                      wayPoints.add(box.stop21);
                      wayPoints.add(box.stop22);
                      wayPoints.add(box.stop23);
                      wayPoints.add(box.stop24);
                      wayPoints.add(box.stop25);
                      wayPoints.add(box.stop26);
                      wayPoints.add(box.stop27);
                      wayPoints.add(box.stop28);
                      wayPoints.add(box.stop29);
                      wayPoints.add(box.stop30);

                      await box.directions!.startNavigation(
                          wayPoints: wayPoints,
                          options: MapBoxOptions(
                              padding: const EdgeInsets.all(100),
                              mode: MapBoxNavigationMode.drivingWithTraffic,
                              simulateRoute: false,
                              language: "en",
                              units: VoiceUnits.metric));
                    },
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  );
                }) 
            

      /// get my location
    );
  }
}

/*


  DirectionsService.init(
      'AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4');

  final directinosService = DirectionsService();

  DirectionsRequest request = const DirectionsRequest(
    origin: "30.081654223476963, 31.35709440794601",
    destination:
        "30.121661245415556, 31.14124346609501",
    travelMode: TravelMode.driving,
  );

  directinosService.route(request, (response, status) {
    if (status == DirectionsStatus.ok) {
      log("Status  = $status");
      log("routes  = ${response.routes!.length}");
    } else {
      log("Status  = $status");
      log("error message  = ${response.routes!.length}");
    }
  });




 */
