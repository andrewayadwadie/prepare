import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/controller/bug_dicover/nearst_visit_controller.dart';
import '../../core/controller/current_location_controller.dart';
import '../../core/controller/epicenter/all_nearst_point_controllerd.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';
import 'daily_controller/daily_work_audio_controller.dart';
import 'daily_controller/daily_work_map_controller.dart';
import 'daily_controller/daily_work_map_proprities_controller.dart';
import 'service/dailty_work_service.dart';

// ignore: must_be_immutable
class DailyWorkScreen extends StatelessWidget {
  DailyWorkScreen({
    Key? key,
    required this.districtLocations,
    required this.districtId,
    required this.routeId,
  }) : super(key: key);
  final List districtLocations;
  final int districtId;
  final int routeId;
  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());
  DailyWorkAudioController audio = Get.put(DailyWorkAudioController());
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
            String message = 'Click again to Exit'.tr;
            Get.snackbar('Exit from the map'.tr, message,
                snackPosition: SnackPosition.BOTTOM,
                animationDuration: const Duration(milliseconds: 500));

            return false;
          } else {
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
                        return GetBuilder<DailyWorkMapPropertiesController>(
                            init: DailyWorkMapPropertiesController(),
                            builder: (prop) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  GetBuilder<NearstBugDiscoverVisit>(
                                      init: NearstBugDiscoverVisit(
                                          prop.redRoutePoint[0]["lat"],
                                          prop.redRoutePoint[0]["long"]),
                                      builder: (discover) {
                                        return GetBuilder<
                                                AllNearstPointsController>(
                                            init: AllNearstPointsController(
                                                prop.redRoutePoint[0]["lat"],
                                                prop.redRoutePoint[0]["long"]),
                                            builder: (epicenter) {
                                              //! google Map Widget
                                              return GoogleMap(
                                                initialCameraPosition:
                                                    prop.initialPosition,
                                                compassEnabled: true,
                                                mapType: MapType.normal,
                                                markers: prop.allMarkers,
                                                polylines: prop.allPolyLine,
                                                myLocationEnabled: true,
                                                myLocationButtonEnabled: true,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) {
                                                  prop.compeleteController
                                                      .complete(controller);
                                                  mapCtrl.convertDataFromApi(
                                                      districtLocations);
                                                  //!<<<<<<<<<<<<<<<<Draw Line from Gis >>>>>>>>>>>>>>
                                                  Future.delayed(const Duration(
                                                          seconds: 2))
                                                      .then((value) {
                                                    mapCtrl.setCurrentPath();
                                                    //! Add point of Discover insects that coming from Api
                                                    mapCtrl.addDiscoverPoints(
                                                        discover.point);
                                                    //! Add point of Epicenter insects that coming from Api
                                                    mapCtrl.addEpicenterPoints(
                                                        epicenter.point);
                                                  });
                                                },
                                              );
                                            });
                                      }),
                                  //! Start Mission Button
                                  if (prop.startMissionButton)
                                    Positioned(
                                        right:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                30,
                                        child: InkWell(
                                          splashColor: primaryColor,
                                          onTap: () {
                                            //! this function to show current point of car and play voices
                                            mapCtrl.startMission(context);
                                            //! this function to draw green line and send path to backend
                                            currentLocation
                                                .location.onLocationChanged
                                                .listen((event) {
                                              currentLocation.location
                                                  .getLocation()
                                                  .then((curent) {
                                                if (mapCtrl.calculateDistance(
                                                        curent.latitude ?? 0.0,
                                                        curent.longitude ?? 0.0,
                                                        event.latitude ?? 0.0,
                                                        event.longitude ??
                                                            0.0) >=
                                                    8) {
                                                  //!<<<<<<<<<<<<<<<< green path that belongs to car>>>>>>>>>>>>>>>>>>>>
                                                  mapCtrl.setnewPath(
                                                      LatLng(
                                                        curent.latitude ?? 0.0,
                                                        curent.longitude ?? 0.0,
                                                      ),
                                                      LatLng(
                                                          event.latitude ?? 0.0,
                                                          event.longitude ??
                                                              0.0));
                                                  //!===================================
                                                  prop.evaluationPoint.add({
                                                    "Lat": event.latitude
                                                        .toString(),
                                                    "Long": curent.longitude
                                                        .toString(),
                                                    "Speed":
                                                        event.speed.toString(),
                                                    "Date": DateTime.now()
                                                        .toString(),
                                                    "RouteNumber": routeId,
                                                    "DistrictId": districtId
                                                  });
                                                  //!<<<<<<<<< send path to backend >>>>>>>>>>>
                                                  net
                                                      .checkInternet()
                                                      .then((val) {
                                                    if (val) {
                                                      //! send green path to Api
                                                      DailyWorkService.addLine(
                                                              data: prop
                                                                  .evaluationPoint)
                                                          .then((value) {
                                                        if (value == 401) {
                                                          Get.offAll(
                                                              const LoginScreen());
                                                        } else if (value ==
                                                            400) {
                                                          Get.snackbar(
                                                              'There is a problem'
                                                                  .tr,
                                                              'There is a problem sending data'
                                                                  .tr);
                                                        } else if (value ==
                                                            200) {
                                                          log("green path status = 200");
                                                          prop.evaluationPoint
                                                              .clear();
                                                          return;
                                                        }
                                                      });
                                                    }
                                                  });
                                                }
                                              });
                                            });

                                            // mapCtrl.getVoicefromList(
                                            //           prop.redRoutePoint);
                                            //!<<<<<<<<<<check if problem is solved will popup with message and remove marker from Markers List>>>>>>>>>//
                                            //setnewPath.isTaskDone();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15,
                                            decoration: BoxDecoration(
                                              color: lightPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'Start the task'.tr,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        )),
                                  //! End Mission Button
                                  if (!prop.startMissionButton)
                                    Positioned(
                                        right:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                30,
                                        child: GetBuilder<InternetController>(
                                            init: InternetController(),
                                            builder: (net) {
                                              return InkWell(
                                                splashColor: primaryColor,
                                                onTap: () {
                                                  /*
                                                  CompleteTaskService.completeTask(districtId:districtId,routeId: routeId)
                                                      .then((value) {
                                                    if (value.runtimeType ==double) {
                                                      Get.defaultDialog(
                                                        title:'Performance evaluation'.tr,
                                                        content: Text("$value %",),
                                                        confirm: InkWell(
                                                          onTap: () {
                                                            Get.offAll(() =>
                                                                const HomeScreen());
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      lightPrimaryColor,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10)),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: MediaQuery
                                                                          .of(
                                                                              context)
                                                                      .size
                                                                      .width /
                                                                  2.5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  20,
                                                              child: Text(
                                                                'finish Task'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17),
                                                              )),
                                                        ),
                                                        barrierDismissible:false,
                                                      );
                                                    } else if (value == 401) {
                                                      Get.offAll(const LoginScreen());
                                                    } else if (value == 400) {
                                                      Get.snackbar('There is a problem'.tr,'There is a problem sending data'.tr);
                                                    }
                                                  });
                                                  */

                                                  Get.defaultDialog(
                                                    title: 'Exit from mission'.tr,
                                                    content:   Text(
                                                      "Want to get off the mission ?".tr,
                                                    ),
                                                    confirm: InkWell(
                                                      onTap: () {
                                                        Get.offAll(() =>
                                                            const HomeScreen());
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  lightPrimaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          alignment: Alignment
                                                              .center,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2 ,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              20,
                                                          child: Text(
                                                            'ok'.tr,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                    cancel: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  redColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          alignment: Alignment
                                                              .center,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2 ,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              20,
                                                          child: Text(
                                                            'cancel'.tr,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                    barrierDismissible: false,
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      15,
                                                  decoration: BoxDecoration(
                                                    color: redColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    'finish Task'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })),
                                ],
                              );
                            });
                      });
                })),
      ),
    );
  }
}
