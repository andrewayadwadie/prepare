import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare/core/controller/current_location_controller.dart';
import 'package:prepare/core/controller/daily_controller/daily_work_map_controller.dart';
import 'package:prepare/core/controller/internet_connectivity_controller.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';
import 'package:prepare/view/daily_work/service/dailty_work_service.dart';

// ignore: must_be_immutable
class DailyWorkScreen extends StatefulWidget {
  const DailyWorkScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyWorkScreen> createState() => _DailyWorkScreenState();
}

class _DailyWorkScreenState extends State<DailyWorkScreen> {
  CurrentLocationController currentLocation =
      Get.put(CurrentLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<DailyWorkMapCtrl>(
              init: DailyWorkMapCtrl(),
              builder: (mapCtrl) {
                return GetBuilder<InternetController>(
                    init: InternetController(),
                    builder: (net) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          GoogleMap(
                            initialCameraPosition: mapCtrl.initialCamPos,
                            mapType: MapType.normal,
                            // onTap: (LatLng newPosition)=> mapCtrl.setGooglePolyLine(),
                            markers: mapCtrl.allMarkers,
                            polylines: mapCtrl.allPolyLine,
                            myLocationEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              mapCtrl.compeleteController.complete(controller);
                              //mapCtrl.setGooglePolyLine();
                              Future.delayed(const Duration(seconds: 2))
                                  .then((value) => mapCtrl.setCurrentPath());
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
                                                date: DateTime.now().toString(),
                                                lat: event.latitude.toString(),
                                                long:
                                                    curent.longitude.toString(),
                                                speed: event.speed.toString())
                                            .then((value) {
                                          if (value == 401) {
                                            Get.offAll(const LoginScreen());
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
                            },
                            onCameraMove: (CameraPosition newPos) {
                              // mapCtrl.setCurrentPath();
                              //mapCtrl.onCamMove(newPos.target);
                              //mapCtrl.setCurrentPath();
                              //mapCtrl.setOriginPath();
                            },
                          ),
                        ],
                      );
                    });
              })),
      floatingActionButton: GetBuilder<DailyWorkMapCtrl>(
          init: DailyWorkMapCtrl(),
          builder: (mapCtrl) {
            return FloatingActionButton(
              onPressed: () {
                mapCtrl.isTaskDone();
              },
              backgroundColor: primaryColor,
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            );
          }),

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
