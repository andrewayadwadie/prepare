import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/controller/bug_dicover/nearst_visit_controller.dart';
import '../../core/controller/current_location_controller.dart';
import '../../core/controller/daily_controller/daily_work_audio_controller.dart';
import '../../core/controller/daily_controller/daily_work_map_controller.dart';
import '../../core/controller/daily_controller/daily_work_map_proprities_controller.dart';
import '../../core/controller/epicenter/all_nearst_point_controllerd.dart';
import '../../core/controller/internet_connectivity_controller.dart';
import '../../utils/style.dart';
import '../auth/login_screen.dart';
import 'service/dailty_work_service.dart';

// ignore: must_be_immutable
class DailyWorkScreen extends StatelessWidget {
  DailyWorkScreen({
    Key? key,
  }) : super(key: key);

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

                                                  //!<<<<<<<<<<<<<<<<Draw Line from Gis >>>>>>>>>>>>>>
                                                  Future.delayed(const Duration(
                                                          seconds: 2))
                                                      .then((value) {
                                                    mapCtrl.setCurrentPath();
                                                    mapCtrl.addDiscoverPoints(
                                                        discover.point);
                                                    mapCtrl.addEpicenterPoints(
                                                        epicenter.point);
                                                  });
                                                  
                                                  currentLocation.location
                                                      .onLocationChanged
                                                      .listen((event) {
                                                    currentLocation.location
                                                        .getLocation()
                                                        .then((curent) {
                                                      if (mapCtrl.calculateDistance(
                                                              curent.latitude,
                                                              curent.longitude,
                                                              event.latitude,
                                                              event.longitude) >
                                                          0.07) {
                                                        //!<<<<<<<<<<<<<<<< green path that belongs to car>>>>>>>>>>>>>>>>>>>>
                                                        mapCtrl.setnewPath(
                                                            LatLng(
                                                              curent.latitude ??
                                                                  0.0,
                                                              curent.longitude ??
                                                                  0.0,
                                                            ),
                                                            LatLng(
                                                                event.latitude ??
                                                                    0.0,
                                                                event.longitude ??
                                                                    0.0));
                                                        //!<<<<<<<<< send path to backend >>>>>>>>>>>
                                                        net
                                                            .checkInternet()
                                                            .then((val) {
                                                          if (val) {
                                                            //! send green path to Api
                                                            if (mapCtrl
                                                                    .isDataDidnotSend ==
                                                                false) {
                                                              DailyWorkService.addLine(
                                                                      date: DateTime
                                                                              .now()
                                                                          .toString(),
                                                                      lat: event
                                                                          .latitude
                                                                          .toString(),
                                                                      long: curent
                                                                          .longitude
                                                                          .toString(),
                                                                      speed: event
                                                                          .speed
                                                                          .toString())
                                                                  .then(
                                                                      (value) {
                                                                if (value ==
                                                                    401) {
                                                                  Get.offAll(
                                                                      const LoginScreen());
                                                                  mapCtrl
                                                                      .changeisDataDidnotSend();
                                                                } else if (value ==
                                                                    400) {
                                                                  Get.snackbar(
                                                                      'There is a problem'
                                                                          .tr,
                                                                      'There is a problem sending data'
                                                                          .tr);
                                                                  mapCtrl
                                                                      .changeisDataDidnotSend();
                                                                } else if (value ==
                                                                    200) {
                                                                  log("status = 200");
                                                                  return;
                                                                }
                                                              });
                                                            }
                                                          }
                                                        });
                                                      }
                                                    });
                                                  });
                                                },
                                              );
                                            });
                                      }),
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
                                            mapCtrl.startMission(context);
                                            mapCtrl.getVoicefromList(
                                                      prop.redRoutePoint);
                                            //!<<<<<<<<<<check if problem is solved will popup with message and remove marker from Markers List>>>>>>>>>//
                                            mapCtrl.isTaskDone();
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
                                ],
                              );
                            });
                      });
                })),
      ),
    );
  }
}
